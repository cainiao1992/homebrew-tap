class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server (with ECH and HTTP/3)"
  homepage "https://curl.se"
  # The version is spelled out in the urls because it must resolve before the
  # `version` DSL line runs; update-curl-formula.rb rewrites all of them.
  # The root spec is the darwin-arm64 build, overridden for Intel below. Having
  # a root spec also lets the formula load on Linux hosts (e.g. the bump CI);
  # it stays uninstallable there because macOS-only.
  url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-8.22.0-ech.1/curl-8.22.0-ech.1-darwin-arm64.tar.gz"
  version "8.22.0-ech.1"
  sha256 "45dd96e995fa6c2589de52c355d70c0650026b9af5338625aad6abd0236890ed"
  license "curl"

  # Version and sha256 are rewritten automatically by .github/workflows/build-curl.yml
  livecheck do
    skip "Custom curl build with ECH; releases are cut by build-curl.yml"
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-8.22.0-ech.1/curl-8.22.0-ech.1-darwin-x64.tar.gz"
      sha256 "dad005264f785072bb0e4d8db49c21e2a80e6e01dbc6324953c6e20228d83488"
    end
  end

  def install
    bin.install "bin/curl"
    man1.install "share/man/man1/curl.1"
  end

  test do
    assert_match version.to_s[/\d+\.\d+\.\d+/], shell_output("#{bin}/curl --version")
    assert_match "HTTP3", shell_output("#{bin}/curl --version")
    assert_match "--ech", shell_output("#{bin}/curl --help all")
  end
end
