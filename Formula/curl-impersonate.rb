class CurlImpersonate < Formula
  desc "Curl build that impersonates browser TLS and HTTP/2 fingerprints"
  homepage "https://github.com/lexiforest/curl-impersonate"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Upstream publishes one tarball per OS/architecture pair. The Linux builds
  # link only against glibc (zlib, brotli, zstd, nghttp2, BoringSSL and c-ares
  # are compiled in statically) and need GLIBC_2.17 or newer.
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.2/curl-impersonate-v2.3.2.arm64-macos.tar.gz"
      sha256 "638ed43cc93cb5da91f794ff23fce1735fec3dc5c09ee87cc499d802c25d2d35"
    else
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.2/curl-impersonate-v2.3.2.x86_64-macos.tar.gz"
      sha256 "4e9fe855a34d011de88bf216c196f6957624526678b99b4f2135acc9ffa8c156"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.2/curl-impersonate-v2.3.2.aarch64-linux-gnu.tar.gz"
      sha256 "35a351db883f5ce82945bd8280c727b08e27aa48594d4eb9e091d8c80e936d52"
    else
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.2/curl-impersonate-v2.3.2.x86_64-linux-gnu.tar.gz"
      sha256 "bc9bd2522fe1850dd54c0fff189c8dd606df3f222ab2a905f2dd255123c3f495"
    end
  end

  def install
    bin.install "curl-impersonate"
    # One wrapper per impersonation target; each execs the binary beside it.
    bin.install Dir["curl_*"]
    doc.install Dir["LICENSE*"]
  end

  test do
    version_output = shell_output("#{bin}/curl-impersonate --version")
    assert_match "IMPERSONATE", version_output
    assert_match "ECH", version_output
    assert_match "--impersonate", shell_output("#{bin}/curl-impersonate --help all")
    # Upstream stamps the release tag into the macOS build only; the Linux
    # build reports "curl-impersonate/local".
    assert_match version.to_s, version_output if OS.mac?
    # The wrapper must resolve the binary installed next to it.
    assert_match "IMPERSONATE", shell_output("#{bin}/curl_chrome152 --version")
  end
end
