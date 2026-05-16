class Gsd2 < Formula
  desc "Meta-prompting, context engineering and spec-driven development system for AI agents"
  homepage "https://github.com/gsd-build/gsd-2"
  version "3.0.0"
  license "MIT"

  depends_on "node@24"

  livecheck do
    url "https://github.com/gsd-build/gsd-2"
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/gsd-v3.0.0/gsd-3.0.0-darwin-arm64.tar.gz"
      sha256 "3ed521f6734f7d3d8541ce9cd546964418a3a8005c013e428ef154fffd0331f1"
    end
    on_intel do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/gsd-v3.0.0/gsd-3.0.0-darwin-x64.tar.gz"
      sha256 "e7b4c686f4f2ddf388589c07aad5daa364623929f4561f1ff243e4d01d3f5508"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cainiao1992/homebrew-tap/releases/download/gsd-v3.0.0/gsd-3.0.0-linux-x64.tar.gz"
      sha256 "22e61747b3e68f76a460643d6bcf6160fcac7368ef4b5287f500b98ec25bc72e"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"node_modules/.bin/gsd" => "gsd"
    bin.install_symlink libexec/"node_modules/.bin/gsd-cli" => "gsd-cli"
    bin.install_symlink libexec/"node_modules/.bin/gsd-pi" => "gsd-pi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsd --version")
  end
end
