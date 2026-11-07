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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.992/kuna-v1.992-macos-arm64.tar.gz"
      sha256 "8cb16d3a2573a6edb3abdfa3210abb884ed85bf6e9b4d5fb5259b68ab5fe5de9"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.992/kuna-v1.992-macos-x86_64.tar.gz"
      sha256 "295abe350b55d0d950d936d5f35693f7f93193d5c279706c1b80d96941bde95e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.992/kuna-v1.992-linux-arm64.tar.gz"
      sha256 "8a6057cf507d7576fa0839de1b43dc2178ce6d119760a5408819a3d814893420"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.992/kuna-v1.992-linux-x86_64-musl.tar.gz"
      sha256 "6e64667a179e8569aa14a1caabbfb613799ea57743eca6d5a46f123ffbf42412"
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
