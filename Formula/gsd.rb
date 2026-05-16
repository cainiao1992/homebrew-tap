class Gsd < Formula
  desc "Meta-prompting, context engineering and spec-driven development system for AI agents"
  homepage "https://github.com/gsd-build/gsd-2"
  url "https://registry.npmjs.org/gsd-pi/-/gsd-pi-3.0.0.tgz"
  sha256 "9222c1f2dcd95e8e78923d1361fb6150fdf5ee8878ea8af9992517187e840724"
  license "MIT"

  depends_on "node"

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsd --version")
  end
end
