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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.988/kuna-v1.988-macos-arm64.tar.gz"
      sha256 "813154009647a7b85775b9227a0b10e0ea312d09c7a5a63444625de8ea82fb95"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.988/kuna-v1.988-macos-x86_64.tar.gz"
      sha256 "b4b278cba3b6021af0b8a133ad3eca872045a615a67c618a754e7e0a16166e4c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.988/kuna-v1.988-linux-arm64.tar.gz"
      sha256 "ab2fbeb341a117e4002b45c2f597cda5be2848fb87a8c15f702afbadd5c0d399"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.988/kuna-v1.988-linux-x86_64-musl.tar.gz"
      sha256 "76801be6d06d415a11d646de83b8480085af92f342f68b2a8c40d604b826db1d"
    end
  end

  def install
    # The tarball holds a single versioned directory with the binary inside.
    dir = Dir["kuna-*"].first
    bin.install "#{dir}/kuna"
    doc.install "#{dir}/LICENSE", "#{dir}/NOTICE"
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
