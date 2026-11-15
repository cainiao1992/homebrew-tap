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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.998/kuna-v1.998-macos-arm64.tar.gz"
      sha256 "e22e641b2bccb49ac29d8ca792adc5effe989691acf017409c050c507f3be40a"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.998/kuna-v1.998-macos-x86_64.tar.gz"
      sha256 "6cfb790eb8b8984297b90ae5386201b9a2a4f4bb1753b9e3e5319810cd6e202b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.998/kuna-v1.998-linux-arm64.tar.gz"
      sha256 "e7232b20ba744e91ea743afd2b94eafb472a57954fc375a3c7f03bfb94473dfb"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.998/kuna-v1.998-linux-x86_64-musl.tar.gz"
      sha256 "ee3924e3bd89e714f76621eda0ca7b78473a5691e40bc1e598b4b7201935e5ca"
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
