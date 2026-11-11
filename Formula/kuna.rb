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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.995/kuna-v1.995-macos-arm64.tar.gz"
      sha256 "a998bf6dd45360ab59a3959c79e51dde63edfa45968c4c24f6e1a7b4b88aa080"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.995/kuna-v1.995-macos-x86_64.tar.gz"
      sha256 "d59dff5816eec61e01493ef1c78d583b87d590208e5f7418e44fe537a6f59980"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.995/kuna-v1.995-linux-arm64.tar.gz"
      sha256 "e4c071192ecb477a2135ed681c59ef14e335bca8aaa790619bcf1bdae18ab7e1"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.995/kuna-v1.995-linux-x86_64-musl.tar.gz"
      sha256 "24431b7aa01f559024a8466dc349ea3dfb46ec0dced431b7aa2d0aade2493df1"
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
