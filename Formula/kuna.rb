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
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.996/kuna-v1.996-macos-arm64.tar.gz"
      sha256 "5e3c96f4db0c5cef30c0c235fbe4717a7839e22d08760219dcfbf0259de1e599"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.996/kuna-v1.996-macos-x86_64.tar.gz"
      sha256 "11be312ed7ea708ca886ab0823220ba32b892d949f7da6aca4057badd0ad16f8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.996/kuna-v1.996-linux-arm64.tar.gz"
      sha256 "e020e7986b6a07bdb13d038d7ac0cf6b7117e67614a94fd6998ebaa60f471b35"
    else
      url "https://github.com/Noelo-Lab/kuna/releases/download/v1.996/kuna-v1.996-linux-x86_64-musl.tar.gz"
      sha256 "ea41d885170905dd1eb0accb0a790939c0d0b1a71e8871fe469e48327ae00a99"
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
