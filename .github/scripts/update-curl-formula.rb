#!/usr/bin/env ruby
# frozen_string_literal: true

# Rewrites Formula/curl.rb with a new version and the per-arch tarball sha256s
# produced by .github/workflows/build-curl.yml.
#
# Usage: update-curl-formula.rb <version> <sha256_arm64> <sha256_x64>
# Exits 1 when nothing changes so the caller can avoid an empty commit.

version, sha_arm64, sha_x64 = ARGV
raise "usage: update-curl-formula.rb <version> <sha256_arm64> <sha256_x64>" unless version && sha_arm64 && sha_x64

path = File.expand_path("../../Formula/curl.rb", __dir__)
content = File.read(path)

content.sub!(/^  version ".*"$/, %Q{  version "#{version}"}) ||
  raise("version line not found in #{path}")

sha_by_arch = { arm64: sha_arm64, x64: sha_x64 }
arch = nil
content = content.lines.map { |line|
  arch = :arm64 if line.include?("on_arm do")
  arch = :x64 if line.include?("on_intel do")
  if (m = line.match(/^(\s*sha256 ")[0-9a-f]{64}(")\n$/))
    "#{m[1]}#{sha_by_arch.fetch(arch)}#{m[2]}\n"
  else
    line
  end
}.join

raise "sha256 placeholders not all replaced" if content.include?("0" * 64)

File.write(path, content)
