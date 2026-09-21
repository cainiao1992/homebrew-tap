#!/usr/bin/env ruby
# frozen_string_literal: true

# Rewrites Casks/zeal.rb with a new version and the per-arch tarball sha256s
# produced by .github/workflows/build-zeal.yml.
#
# Usage: update-zeal-cask.rb <version> <sha256_arm64> <sha256_x64>

version, sha_arm, sha_intel = ARGV
raise "usage: update-zeal-cask.rb <version> <sha256_arm64> <sha256_x64>" unless version && sha_arm && sha_intel

path = File.expand_path("../../Casks/zeal.rb", __dir__)
before = File.read(path)

content = before.dup
content.sub!(/^  version ".*"$/, %Q{  version "#{version}"}) ||
  raise("version line not found in #{path}")
content.sub!(/^  sha256 arm: "[0-9a-f]{64}",$/, %Q{  sha256 arm: "#{sha_arm}",}) ||
  raise("arm sha256 line not found in #{path}")
content.sub!(/^         intel: "[0-9a-f]{64}"$/, %Q{         intel: "#{sha_intel}"}) ||
  raise("intel sha256 line not found in #{path}")

raise "placeholder sha not replaced" if content.include?("0" * 64)

File.write(path, content)
