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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1000/kuna-v1.1000-macos-arm64.tar.gz"
      sha256 "e88eaa860d69706a6d9c2ef28af227424335667397cca55285c9969f58620133"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1000/kuna-v1.1000-macos-x86_64.tar.gz"
      sha256 "91c26c3a1a0c5fcf7806d5847759c5062fffdc634fbc357a71a89cea352e4f23"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1000/kuna-v1.1000-linux-arm64.tar.gz"
      sha256 "7e530c360cf4ecd529c8879b2dbcdca40201e18fdcc2002ae5ac8cf172fe16b5"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1000/kuna-v1.1000-linux-x86_64-musl.tar.gz"
      sha256 "df4f6b4aca44f3628fed3f539109f90b332ebc1bd4427af7fea5f10a82aed830"
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
