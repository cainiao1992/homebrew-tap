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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.989/kuna-v1.989-macos-arm64.tar.gz"
      sha256 "4061b81c656ed4f2697e5669898f3d89e1c7355a57090afa765942ef455a704e"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.989/kuna-v1.989-macos-x86_64.tar.gz"
      sha256 "e0b8848357fd414025d0199878d5856986f6f004396b2f8bb7f74e1f6eb1960c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.989/kuna-v1.989-linux-arm64.tar.gz"
      sha256 "b5f12a6751a02ddd7c245c4ebfde008542041d702c7438dc30e778ae6216c47e"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.989/kuna-v1.989-linux-x86_64-musl.tar.gz"
      sha256 "2383a2d05915a647ffbc74048e78cb08a2b3a8ea9d6799f89ab2cc484ac4a653"
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
