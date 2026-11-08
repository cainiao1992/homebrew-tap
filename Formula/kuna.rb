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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.993/kuna-v1.993-macos-arm64.tar.gz"
      sha256 "cc1d9525dba79f973052cc7822ee3dae5402cceb2784e23bd57ccc312ec7717b"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.993/kuna-v1.993-macos-x86_64.tar.gz"
      sha256 "f7113c5267618ea0bfacb60d44352d2042ff5ee706c3d68df55e5c1f1dd916de"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.993/kuna-v1.993-linux-arm64.tar.gz"
      sha256 "06b8845f6999708aad78d1dabdf0ec7452072222f43710b73c550f2941768992"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.993/kuna-v1.993-linux-x86_64-musl.tar.gz"
      sha256 "9f5fe652c47931d658ca9eea56afee4a74df6db0db28d46d819d48fec322e72e"
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
