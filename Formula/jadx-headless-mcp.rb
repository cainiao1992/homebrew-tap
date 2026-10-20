class JadxHeadlessMcp < Formula
  desc "Headless MCP server for Android APK static analysis built on jadx-core"
  homepage "https://github.com/1013503897/jadx-headless-mcp"
  url "https://github.com/1013503897/jadx-headless-mcp/releases/download/v0.8.0/jadx-headless-mcp-0.8.0-all.jar"
  sha256 "4b9a01c23845c123c217840182d2b5f2c26a7ca20dec3d08810b310fc80a2372"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install "jadx-headless-mcp-#{version}-all.jar" => "jadx-headless-mcp.jar"
    # Matches the JVM defaults of the upstream installDist launcher.
    bin.write_jar_script libexec/"jadx-headless-mcp.jar", "jadx-headless-mcp",
                         "-XX:MaxRAMPercentage=60.0"
  end

  def caveats
    <<~EOS
      This tool requires JDK 17+ to run.

      jadx-headless-mcp speaks MCP over stdio, so it is normally spawned by an
      MCP client rather than run by hand. Register it with:

        claude mcp add jadx-headless -s user -- #{opt_bin}/jadx-headless-mcp

      Then ask the client to call `load_apk` with the path to analyse.
    EOS
  end

  test do
    # Usage text is printed on stderr: Main.kt redirects System.out to stderr
    # so that stdout carries only the MCP JSON-RPC traffic.
    assert_match "Headless JADX-based MCP server",
                 shell_output("#{bin}/jadx-headless-mcp --help 2>&1")
  end
end
