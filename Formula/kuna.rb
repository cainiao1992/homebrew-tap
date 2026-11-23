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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1004/kuna-v1.1004-macos-arm64.tar.gz"
      sha256 "2aa1c60dea9ab7b02d4fae3da6a200f0d8556eae2d0bbdb4c74ffda27eebf7d5"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1004/kuna-v1.1004-macos-x86_64.tar.gz"
      sha256 "be369d8eac49ed14ba8949f9a1e1bffff1fe2bd148026c5a6cb2c087398e0745"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1004/kuna-v1.1004-linux-arm64.tar.gz"
      sha256 "e33099069846abb6d49873dc9e2a1bf65cc579757f2e9590b3298554ccc59785"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1004/kuna-v1.1004-linux-x86_64-musl.tar.gz"
      sha256 "23bfd713f4773be055bdba8cd614a6637ae861c77123b8c029a859b254f30da4"
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
