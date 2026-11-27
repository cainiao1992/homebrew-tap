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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1007/kuna-v1.1007-macos-arm64.tar.gz"
      sha256 "4cb6ab7d02f9e364c61776b752f0ec89e9ba9fb9b1a033dd2a9a396f74b45087"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1007/kuna-v1.1007-macos-x86_64.tar.gz"
      sha256 "8431860363f57a6ae6b492e9788c47b95b5d75efc9c667757e89150f853307eb"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1007/kuna-v1.1007-linux-arm64.tar.gz"
      sha256 "e6a321a61105284bda8b1118307a9d6b301ce42b5bedf3d986aa73ea1c27e878"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1007/kuna-v1.1007-linux-x86_64-musl.tar.gz"
      sha256 "86ee8a3620c755f7260161352f3bb3a69feb4045b6e5604ee58f77e4d0cc2ee3"
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
