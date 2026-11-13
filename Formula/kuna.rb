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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.997/kuna-v1.997-macos-arm64.tar.gz"
      sha256 "b2aa5d7c1befb0b6eecc19484633eb109bfc32f84a92544b44b37ebc6e18b891"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.997/kuna-v1.997-macos-x86_64.tar.gz"
      sha256 "87fa5673c5907d81e031bccd00277c8fd004c9d191a6e294664cf0613673ceee"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.997/kuna-v1.997-linux-arm64.tar.gz"
      sha256 "acd4f7e49758212ad45d26f7cad41d26d4c25a891d2ccd735b38f53b16165f3b"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.997/kuna-v1.997-linux-x86_64-musl.tar.gz"
      sha256 "09ec270bc53d7fc39d1d93a9e724ba7c03c8b067997b025ca65d4145499e13cc"
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
