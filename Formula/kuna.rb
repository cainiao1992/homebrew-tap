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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1001/kuna-v1.1001-macos-arm64.tar.gz"
      sha256 "575f4599cb687ffe68884de01442b6a5b3018af809047b4d4aeffc1a9bf3eb57"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1001/kuna-v1.1001-macos-x86_64.tar.gz"
      sha256 "f572b9b6299c78f2f6b402915826fe56c80c82c7a0d6c3bc251135289e5ee013"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1001/kuna-v1.1001-linux-arm64.tar.gz"
      sha256 "b94985ff81b1af18ef3ba817f33d5c386d2d98df789206951cae0403cf5e6902"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1001/kuna-v1.1001-linux-x86_64-musl.tar.gz"
      sha256 "656a3b45b22095fffd072c04697c3c909afdbf1584c98ae85206b06ba96bbd26"
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
