class Bun < Formula
  desc "Incredibly fast JavaScript runtime, bundler, transpiler and package manager"
  homepage "https://bun.sh/"
  url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-x64.zip"
  version "1.4.1"
  sha256 "74c1c3bee7cd998500c8f969cd8972355ac6a07207e94a39eece1999b56ffabf" # bun-linux-x64.zip
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Primary (Linux x86_64) build. `brew bump-formula-pr` requires a root
  # `url`/`sha256` stanza; the per-platform overrides below take precedence
  # when their conditions match.
  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-aarch64.zip"
      sha256 "d8973ce835fa7867e5cc79afee6fc6f1ae0117aa4bd5fc2546fd00c512f71386" # bun-darwin-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-x64.zip"
      sha256 "8f34239f276a3f0d27bfcd1ffecfe5d2127e74fb0aa4c0971a0cdec7b225c965" # bun-darwin-x64.zip
    else
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-darwin-x64-baseline.zip"
      sha256 "498e76d61bbe87d2306f65fed60ae86b6b0c8ee2da709f83202808db1a09e407" # bun-darwin-x64-baseline.zip
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-aarch64.zip"
      sha256 "580ce77533108dc6b10bec1721397e4f5aa44e909726da2451d483dfc5e581d6" # bun-linux-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-x64.zip"
      sha256 "74c1c3bee7cd998500c8f969cd8972355ac6a07207e94a39eece1999b56ffabf" # bun-linux-x64.zip
    else
      url "https://github.com/oven-sh/bun/releases/download/bun-v#{version}/bun-linux-x64-baseline.zip"
      sha256 "a8c9c6738202e2fced555dd860a953c56c0cd059f75041e7010ae81a32802646" # bun-linux-x64-baseline.zip
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://bun.sh/issues\n#{OS.report}"
  end

  # TODO: to become an official formula we need to build from source
  def install
    bin.install "bun"
    ENV["BUN_INSTALL"] = bin.to_s
    generate_completions_from_executable(bin/"bun", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bun -v")
  end
end
