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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.991/kuna-v1.991-macos-arm64.tar.gz"
      sha256 "b4559c105a68acb81eada0629dc938d224f4696f670dff01f21584ba44ecea9b"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.991/kuna-v1.991-macos-x86_64.tar.gz"
      sha256 "1bc060fdd2615a9fca7c6697f85d410924ad6061711fb7ed550514c8181c96ad"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.991/kuna-v1.991-linux-arm64.tar.gz"
      sha256 "b1b615d711f9da8378d7548c7aeea955effb3af7d386f8eb6999159594066301"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.991/kuna-v1.991-linux-x86_64-musl.tar.gz"
      sha256 "0df5ca05b28f00dd7fdc664eef69264e82f22788c687407302891e45bac0f575"
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
