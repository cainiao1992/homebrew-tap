#!/usr/bin/env ruby
# frozen_string_literal: true

# Rewrites Casks/zeal.rb with a new version and the arm64 zip sha256 produced
# by .github/workflows/build-zeal.yml.
#
# Usage: update-zeal-cask.rb <version> <sha256>
# Exits 1 when nothing changes so the caller can avoid an empty commit.

version, sha256 = ARGV
raise "usage: update-zeal-cask.rb <version> <sha256>" unless version && sha256

path = File.expand_path("../../Casks/zeal.rb", __dir__)
before = File.read(path)

content = before.dup
content.sub!(/^  version ".*"$/, %Q{  version "#{version}"}) ||
  raise("version line not found in #{path}")
content.sub!(/^  sha256 arm: "[0-9a-f]{64}"$/, %Q{  sha256 arm: "#{sha256}"}) ||
  raise("sha256 line not found in #{path}")

raise "placeholder sha not replaced" if content.include?("0" * 64)

File.write(path, content)
exit 1 if content == before
