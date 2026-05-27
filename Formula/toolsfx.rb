class Toolsfx < Formula
  desc "Cross-platform cryptography toolbox (encoding, encryption, hashing, QR codes)"
  homepage "https://github.com/Leon406/ToolsFx"
  url "https://github.com/Leon406/ToolsFx/releases/download/v1.19.0/ToolsFx-1.19.0-jdk17-no-jfx-all-platform.zip",
      using: :nounzip
  sha256 "f49bbc531f1a32c9757749c26624a554b36d230581f520914de4220c13bab6e6"
  license "ISC"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.mkpath
    safe_system "unzip", "-qq", "-o", cached_download,
                "ToolsFx", "ToolsFx.properties", "lib/*",
                "-d", libexec
    (libexec/"ToolsFx").chmod 0755

    env = Language::Java.overridable_java_home_env
    (bin/"toolsfx").write_env_script <<~SHELL, env
      cd "#{libexec}" || exit 1
      exec "./ToolsFx" "$@"
    SHELL
  end

  test do
    assert_path_exists libexec/"lib/app-#{version}.jar"
    assert_path_exists libexec/"ToolsFx"
  end
end
