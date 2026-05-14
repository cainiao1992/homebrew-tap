class UberApkSigner < Formula
  desc "CLI tool for signing, zip aligning and verifying Android APKs"
  homepage "https://github.com/patrickfav/uber-apk-signer"
  url "https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar"
  sha256 "e1299fd6fcf4da527dd53735b56127e8ea922a321128123b9c32d619bba1d835"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install "uber-apk-signer-#{version}.jar" => "uber-apk-signer.jar"
    bin.write_jar_script libexec/"uber-apk-signer.jar", "uber-apk-signer"
  end

  def caveats
    <<~EOS
      This tool requires JDK 8+ to run. It has an embedded debug keystore and
      zipalign for convenience, but you can also provide your own via CLI flags.

      Usage:
        uber-apk-signer --apks /path/to/app.apk

      To use system zipalign instead of the built-in one, install separately:
        brew install android-platform-tools
        uber-apk-signer --apks /path/to/app.apk --zipAlignPath $(which zipalign)
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uber-apk-signer --help")
  end
end
