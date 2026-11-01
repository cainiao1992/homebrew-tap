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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.987/kuna-v1.987-macos-arm64.tar.gz"
      sha256 "c680ad1fda73365faf7f1949742644642273c6c8b3f1a07fe864fb0e56e9185e"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.987/kuna-v1.987-macos-x86_64.tar.gz"
      sha256 "a6abf45c7cec5e91dad84fde7967dbc4c2b7c73f8e60bdec6585a0617eb93147"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.987/kuna-v1.987-linux-arm64.tar.gz"
      sha256 "2f75c458bf771c34e54ad9c3791133d92a2d7808f3f15edf34307f4e2485a1c6"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.987/kuna-v1.987-linux-x86_64-musl.tar.gz"
      sha256 "930d98696256e545fdd2b0ac0bb0a96db389b2df1226ee8cb1cf354e7a6a9e7d"
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
