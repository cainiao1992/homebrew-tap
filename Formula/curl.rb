class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server (with ECH and HTTP/3)"
  homepage "https://curl.se"
  # The version is spelled out in the urls because it must resolve before the
  # `version` DSL line runs; update-curl-formula.rb rewrites all of them.
  # The root spec is the darwin-arm64 build, overridden for Intel below. Having
  # a root spec also lets the formula load on Linux hosts (e.g. the bump CI);
  # it stays uninstallable there because macOS-only.
  url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-8.23.0-ech.1/curl-8.23.0-ech.1-darwin-arm64.tar.gz"
  version "8.23.0-ech.1"
  sha256 "5f7b310e1465a7bd3f70365131433579a06e0a43afc121e6da0d46a741dbb608"
  license "curl"

  # Version and sha256 are rewritten automatically by .github/workflows/build-curl.yml
  livecheck do
    skip "Custom curl build with ECH; releases are cut by build-curl.yml"
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-8.23.0-ech.1/curl-8.23.0-ech.1-darwin-x64.tar.gz"
      sha256 "49c7ea709b502c76ca2bbc15bb4cf4f3a86a272d5f30c655c7c3ee17ef501a9d"
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
