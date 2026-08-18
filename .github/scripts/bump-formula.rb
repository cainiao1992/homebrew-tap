#!/usr/bin/env ruby
# frozen_string_literal: true

# Bumps a Homebrew formula's version, URLs and checksums.
#
# `brew bump-formula-pr` only rewrites root-level `url`/`sha256` stanzas, so it
# cannot handle formulae that define per-platform URLs inside `if OS.mac?` or
# `on_macos`/`on_linux` blocks (e.g. multi-variant releases). This script
# rewrites every stable `url`/`sha256` pair instead, leaving `resource` blocks
# untouched. URLs may embed `#{version}` or a hardcoded version tag.
#
# The file is only written when every checksum re-download succeeds, so a
# failed bump leaves the formula untouched.
#
# Usage: brew ruby .github/scripts/bump-formula.rb <formula> <new-version>

require "digest"
require "open3"
require "pathname"

name, new_version = ARGV
abort "usage: bump-formula.rb <formula> <new-version>" if name.nil? || new_version.nil?

path = Pathname("Formula/#{name}.rb")
contents = path.read

old_version = contents[/^\s*version\s+"([^"]+)"/, 1]
abort "#{name}: no `version` stanza found" if old_version.nil?

# Replace the old version everywhere (the `version` stanza and any hardcoded
# version tags inside URLs). Word boundaries avoid partial-match corruption.
contents = contents.gsub(/\b#{Regexp.escape(old_version)}\b/, new_version)

# Strip `resource` blocks so their pinned URLs/checksums are never rewritten.
stable_part = contents.dup
stable_part.gsub!(/^  resource\s+"[^"]+"\s+do.*?^  end$/m, "")

urls = stable_part.scan(/^\s*url\s+"((?:[^"\\]|\\.)*)"/).flatten
                   .map { |url| url.gsub('#{version}', new_version) }
shas = stable_part.scan(/^\s*sha256\s+"([0-9a-f]{64})"/).flatten

if urls.size != shas.size
  abort "#{name}: #{urls.size} `url` stanzas but #{shas.size} `sha256` stanzas"
end

# Re-download every variant first; abort without writing if any fails.
new_shas = Array.new(shas.size)
shas.each_with_index do |_old_sha, i|
  url = urls[i]
  tmp = "/tmp/bump-formula-download"
  _out, err, status = Open3.capture3("curl", "-fsSL", "-o", tmp, url)
  abort "#{name}: download failed for #{url}: #{err.strip}" unless status.success?

  new_shas[i] = Digest::SHA256.file(tmp).hexdigest
end

updated = contents
shas.each_with_index do |old_sha, i|
  new_sha = new_shas[i]
  next if old_sha == new_sha

  # Replace only the i-th occurrence so duplicated checksums (e.g. the same
  # build listed as both the root and a per-platform URL) are all updated.
  seen = 0
  updated = updated.gsub(old_sha) { (seen += 1) == i + 1 ? new_sha : old_sha }
end

path.write(updated)

if updated == contents
  puts "#{name}: no checksum changes for #{old_version} -> #{new_version}"
  exit 0
end

git_add = Open3.capture3("git", "add", "Formula/#{name}.rb").last
abort "#{name}: git add failed" unless git_add.success?

git_commit = Open3.capture3("git", "commit", "-m", "#{name} #{new_version}").last
abort "#{name}: git commit failed" unless git_commit.success?

puts "#{name}: #{old_version} -> #{new_version} (#{shas.size} checksums updated)"
