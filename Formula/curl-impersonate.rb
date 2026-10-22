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
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.0/curl-impersonate-v2.3.0.arm64-macos.tar.gz"
      sha256 "2dfb4b5733e01ec88f9cc7363696c848d0a2b810584d4c0fac7719f82b985f8f"
    else
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.0/curl-impersonate-v2.3.0.x86_64-macos.tar.gz"
      sha256 "4c1aff4a561728300a3f05384ec2e519e513ed90542f62c7d142c6c379f1d4e6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.0/curl-impersonate-v2.3.0.aarch64-linux-gnu.tar.gz"
      sha256 "c494a906529519f41c23b54c85225249cf75f833c1cb1ee5eb630f7d785b4a8b"
    else
      url "https://github.com/lexiforest/curl-impersonate/releases/download/v2.3.0/curl-impersonate-v2.3.0.x86_64-linux-gnu.tar.gz"
      sha256 "5e77cb12217158f118ead21ab550791788e553fb140d03a49d74d08308ebdb06"
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
