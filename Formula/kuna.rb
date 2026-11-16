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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.999/kuna-v1.999-macos-arm64.tar.gz"
      sha256 "d04cd0b5d1c9be37b790591a68007f9ee3039a2ed2c16349bc0599dcb2716865"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.999/kuna-v1.999-macos-x86_64.tar.gz"
      sha256 "deca7d3b7e04f51b706992451f124c0d0eefd5352a8d997601826f133be06368"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.999/kuna-v1.999-linux-arm64.tar.gz"
      sha256 "c453af2084b8eb31669988a71e3d7fc8df8a10494450914b7ca7da3643ebedf6"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.999/kuna-v1.999-linux-x86_64-musl.tar.gz"
      sha256 "941953e913a79ae0cac23e3261e2298de48b3560423d1cd0eb996f8d3c3f9e3e"
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
