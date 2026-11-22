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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1003/kuna-v1.1003-macos-arm64.tar.gz"
      sha256 "a35f339df026d87b60759849a934a549cb73dea6b76d9b8a104b25cff9b52bb9"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1003/kuna-v1.1003-macos-x86_64.tar.gz"
      sha256 "1f8492a28887cc9717a1312e4ede3460f6f30d443386a396dc04f077aa7cf364"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1003/kuna-v1.1003-linux-arm64.tar.gz"
      sha256 "28b99d7839ade2fc7cf9d019276338a9732ef323e9c0a9739b731bc477b26e8f"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1003/kuna-v1.1003-linux-x86_64-musl.tar.gz"
      sha256 "aac37a4805e69500ae65aa7ed4ce32b706dacbc3fa444c488ba72c0548587c81"
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
