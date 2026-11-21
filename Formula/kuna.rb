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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1002/kuna-v1.1002-macos-arm64.tar.gz"
      sha256 "bd50881f53c95b53396644ce9073e6bb2befae3a8a7a3dae62d96ca9f247b02a"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1002/kuna-v1.1002-macos-x86_64.tar.gz"
      sha256 "e8ce152d2230a6d61080bee0dc589b0629424a515e645a6037cd0473fab6c5d1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1002/kuna-v1.1002-linux-arm64.tar.gz"
      sha256 "9c259186e64673e9e1858a6a0415ace3e5ae8974076486c24053c71c715531c2"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.1002/kuna-v1.1002-linux-x86_64-musl.tar.gz"
      sha256 "b76620fca15d81bbcee61cbf8bacd2e36ab604cf60c8359ab7503136d077089f"
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
