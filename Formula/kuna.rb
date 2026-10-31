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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.986/kuna-v1.986-macos-arm64.tar.gz"
      sha256 "23c9842df9cd6f29beff1905af96ea9767628a0605487e859d5f7d727579b3de"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.986/kuna-v1.986-macos-x86_64.tar.gz"
      sha256 "1559633d49a1993fd26d3a7744f4ef7d9a7a99219b37cbcb40ffe3cf5bdfed0d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.986/kuna-v1.986-linux-arm64.tar.gz"
      sha256 "763f63339c6df54ac0390161c07f0c36c597313b3782a0aa759931114e50543e"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.986/kuna-v1.986-linux-x86_64-musl.tar.gz"
      sha256 "78a7ec8c40a0adb3949bb318cc27c3c5642b9bcd024e02c95ba35bf620afd758"
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
