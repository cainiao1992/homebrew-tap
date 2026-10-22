#!/usr/bin/env ruby
# frozen_string_literal: true

# Bumps a Homebrew formula's version, URLs and checksums.
#
# `brew bump-formula-pr` only rewrites root-level `url`/`sha256` stanzas, so it
# cannot handle formulae that define per-platform URLs inside `if OS.mac?` or
# `on_macos`/`on_linux` blocks (e.g. multi-variant releases). This script
# rewrites every stable `url`/`sha256` pair instead. URLs may embed
# `#{version}` or a hardcoded version tag.
#
# Checksums are matched to URLs by asset name, the convention used by
# `oven-sh/homebrew-bun`'s `scripts/release.rb`:
#
#     url "https://…/bun-linux-aarch64.zip"
#     sha256 "…" # bun-linux-aarch64.zip
#
# The trailing comment is the lookup key, so neither the stanza order nor the
# checksum order has to be kept in sync by hand. A formula that annotates only
# some of its checksums is rejected rather than guessed at; a formula with no
# annotations at all falls back to pairing by position, which is how formulae
# maintained elsewhere (e.g. by their own release workflow) keep working.
#
# The file is only written when every checksum re-download succeeds, so a
# failed bump leaves the formula untouched.
#
# Usage: brew ruby .github/scripts/bump-formula.rb <formula> <new-version>

require "digest"
require "open3"

# Regexes, not strings, so `Lint/InterpolationCheck` cannot "simplify" them.
VERSION_INTERPOLATION = /#\{version\}/.freeze
ASSET_COMMENT = /#\s*(\S+)/.freeze

name, new_version = ARGV
abort "usage: bump-formula.rb <formula> <new-version>" if name.nil? || new_version.nil?

file = "Formula/#{name}.rb"
contents = File.read(file)

old_version = contents[/^\s*version\s+"([^"]+)"/, 1]

# Formulae pinned by hardcoded release tags carry no `version` stanza — audit
# rejects one that only repeats the tag scanned from the URL. Read the version
# off the release tag instead ("…/download/v2.3.0/curl-impersonate-v2.3.0.…").
# `\b` cannot match there (the tag is glued to a `v`), so this branch uses
# digit lookarounds: the `v` is left untouched and stays in the rewritten URL,
# while a leading `1` in "12.3.0" still cannot match "2.3.0".
version_pattern =
  if old_version
    /\b#{Regexp.escape(old_version)}\b/
  else
    old_version = contents[%r{/releases/download/v?([^/"]+)/}, 1]
    abort "#{name}: no `version` stanza and no `/releases/download/<tag>/` URL" if old_version.nil?

    /(?<!\d)#{Regexp.escape(old_version)}(?!\d)/
  end

# Replace every version occurrence in the file (the `version` stanza and any
# hardcoded version tags inside URLs). The guards avoid partial-match
# corruption. `#{version}` placeholders stay intact in the file and are only
# expanded in `stable_part` below, for URL extraction.
contents = contents.gsub(version_pattern, new_version)

# Strip `resource` and `livecheck` blocks so their pinned URLs/checksums are
# never rewritten or counted as stable URLs.
stable_part = contents.dup
stable_part.gsub!(VERSION_INTERPOLATION, new_version)
stable_part.gsub!(/^  resource\s+"[^"]+"\s+do.*?^  end$/m, "")
stable_part.gsub!(/^  livecheck\s+do.*?^  end$/m, "")

stable_urls = stable_part.scan(/^\s*url\s+"((?:[^"\\]|\\.)*)"/).flatten
stable_shas = stable_part.scan(/^\s*sha256\s+"([0-9a-f]{64})"(.*)$/)
abort "#{name}: no `url`/`sha256` stanzas found" if stable_shas.empty?

named_shas = stable_shas.map { |(sha, trailing)| [sha, trailing[ASSET_COMMENT, 1]] }

checksum_urls =
  if named_shas.none? { |(_sha, asset)| asset.nil? }
    urls_by_asset = stable_urls.to_h { |url| [url.split("/").last, url] }
    if urls_by_asset.size != stable_urls.size
      abort "#{name}: repeated asset names make `# <asset-name>` matching ambiguous"
    end

    named_shas.map do |(sha, asset)|
      url = urls_by_asset[asset]
      abort "#{name}: no `url` stanza ends in #{asset}" if url.nil?

      [sha, url]
    end
  else
    if named_shas.any? { |(_sha, asset)| !asset.nil? }
      abort "#{name}: only some `sha256` stanzas name their asset in a trailing comment"
    end

    if stable_urls.size != stable_shas.size
      abort "#{name}: #{stable_urls.size} `url` stanzas but #{stable_shas.size} `sha256` stanzas"
    end

    puts "#{name}: no `# <asset-name>` comments; pairing checksums by position"
    stable_shas.map(&:first).zip(stable_urls)
  end

# Re-download every variant first; abort without writing if any fails.
new_shas = checksum_urls.map do |_old_sha, url|
  tmp = "/tmp/bump-formula-download"
  _out, err, status = Open3.capture3("curl", "-fsSL", "-o", tmp, url)
  abort "#{name}: download failed for #{url}: #{err.strip}" unless status.success?

  Digest::SHA256.file(tmp).hexdigest
end

# Rewrite every occurrence of each old checksum. A repeated old value always
# maps to one new value (same checksum implies the same asset), so global
# replacement is safe; conflicting mappings would mean a broken formula.
sha_map = {}
checksum_urls.each_with_index do |(old_sha, _url), i|
  next if old_sha == new_shas[i]

  if sha_map.key?(old_sha) && sha_map[old_sha] != new_shas[i]
    abort "#{name}: conflicting new checksums for #{old_sha}"
  end

  sha_map[old_sha] = new_shas[i]
end

updated = contents
sha_map.each { |old_sha, new_sha| updated = updated.gsub(old_sha, new_sha) }

File.write(file, updated)

if updated == contents
  puts "#{name}: no checksum changes for #{old_version} -> #{new_version}"
  exit 0
end

git_add = Open3.capture3("git", "add", "Formula/#{name}.rb").last
abort "#{name}: git add failed" unless git_add.success?

git_commit = Open3.capture3("git", "commit", "-m", "#{name} #{new_version}").last
abort "#{name}: git commit failed" unless git_commit.success?

puts "#{name}: #{old_version} -> #{new_version} (#{sha_map.size} checksums updated)"
