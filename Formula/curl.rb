class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server (with ECH and HTTP/3)"
  homepage "https://curl.se"
  version "8.21.0-ech.1"
  license "curl"

  # Version and sha256 are rewritten automatically by .github/workflows/build-curl.yml
  livecheck do
    skip "Custom curl build with ECH; releases are cut by build-curl.yml"
  end

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-#{version}/curl-#{version}-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/curl-#{version}/curl-#{version}-darwin-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
