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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1005/kuna-v1.1005-macos-arm64.tar.gz"
      sha256 "b49897086e608b69e58c2b0abdc51113fe326c818dbd1bfed2a8b066e2ff5252"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1005/kuna-v1.1005-macos-x86_64.tar.gz"
      sha256 "ff43bb837adbabf7bee443db27da6c99063e5e8a448820c23ae2c1b9111f74b1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1005/kuna-v1.1005-linux-arm64.tar.gz"
      sha256 "cc9c8ac864e53d723c6f189739196c3a0ee84a3efa3714ab0886080699f16574"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1005/kuna-v1.1005-linux-x86_64-musl.tar.gz"
      sha256 "dc632c77d4040ac24d8d6e0204dfdea4382db1e194577c214beb5e402464f887"
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
