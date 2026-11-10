class Kuna < Formula
  desc "Binary decompiler built for agent-driven refinement"
  homepage "https://github.com/Noelo-Lab/kuna"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The Linux x86_64 build is the musl variant: upstream's glibc build asks for
  # GLIBC_2.39, which makes every run print "weak version `GLIBC_2.39' not
  # found" on older distributions (Debian 12, Ubuntu 22.04). The static musl
  # build has no runtime dependency at all. Only x86_64 ships a musl variant,
  # so arm64 Linux keeps the glibc build.
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.994/kuna-v1.994-macos-arm64.tar.gz"
      sha256 "9dff8e2de5cc2afd359c57fddf4a868a57c66cfd9e22732d37bb4ed4e794a17a"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.994/kuna-v1.994-macos-x86_64.tar.gz"
      sha256 "c027d616b005fa09c77783c332db2e3414de7a67dde2d93e73bb7adae0f8fab3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.994/kuna-v1.994-linux-arm64.tar.gz"
      sha256 "473c9885574540f340f0ab1a50ac8e7f18b244b4d2ee98156ebfc81a595077d8"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.994/kuna-v1.994-linux-x86_64-musl.tar.gz"
      sha256 "eb9ac9039e355802293169b5b5a53dfac58dce4b2fb3389112e1767c51bd4ca2"
    end
  end

  def install
    # Upstream tarballs wrap everything in kuna-<version>-<os>-<arch>/, and
    # Homebrew chdirs into a lone top-level directory while staging, so the
    # payload already sits directly in the working directory here.
    bin.install "kuna"
    doc.install "LICENSE", "NOTICE"
  end

  def caveats
    <<~EOS
      Kuna ships a skill that teaches coding agents how to drive its CLI.
      Install it once with:
        kuna install-skill
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kuna --version")
    # The SLEIGH specs are compiled into the binary; `docs` reads them back
    # without touching the network or any external data directory.
    assert_match "cli", shell_output("#{bin}/kuna docs")
  end
end
