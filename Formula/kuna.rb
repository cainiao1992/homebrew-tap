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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.990/kuna-v1.990-macos-arm64.tar.gz"
      sha256 "f1469757ef329542951640439198afe836e1ead90e3bf3d544b10e27d4e6ed3e"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.990/kuna-v1.990-macos-x86_64.tar.gz"
      sha256 "58886b210d42dc3f40fff202b979cbf8bef7ddc663447d09f52c97ccdd1fc1d1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.990/kuna-v1.990-linux-arm64.tar.gz"
      sha256 "8492ccd011c51aeac670435ab00ac3166400ad65f41b0198b6d9689ef2c147b9"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.990/kuna-v1.990-linux-x86_64-musl.tar.gz"
      sha256 "2cf97d8becd9dc5fef7495c14776e19066d1a9206b85983878ea16b321764853"
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
