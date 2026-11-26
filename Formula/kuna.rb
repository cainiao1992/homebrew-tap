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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1006/kuna-v1.1006-macos-arm64.tar.gz"
      sha256 "21466b052d8349f1fdf71fc3bd9adace8db78fc6203f74f16c285ab18143f7a2"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1006/kuna-v1.1006-macos-x86_64.tar.gz"
      sha256 "84112467f474428b363824e2cbd070ef8f9481be08adbc7f6088379f042f3762"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1006/kuna-v1.1006-linux-arm64.tar.gz"
      sha256 "bb58c0e8ed82c21ed5d8fa6728b7e29a21a89a4daf2d8123ee614b9d59f33e4b"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1006/kuna-v1.1006-linux-x86_64-musl.tar.gz"
      sha256 "538eecbbada72ca52beaf5c96127c2183444eebab66f8f033a624d9298157fd4"
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
