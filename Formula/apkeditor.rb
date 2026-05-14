class Apkeditor < Formula
  desc "APK editor for parsing, decoding, and editing Android APK files"
  homepage "https://github.com/REAndroid/APKEditor"
  url "https://github.com/REAndroid/APKEditor/releases/download/V1.4.8/APKEditor-1.4.8.jar"
  sha256 "026906af28497577496a3e1f5054a878a7cf9c1b3889626882d87ea88d09c20f"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install "APKEditor-#{version}.jar" => "APKEditor.jar"
    bin.write_jar_script libexec/"APKEditor.jar", "APKEditor"
  end

  def caveats
    <<~EOS
      This tool requires JDK 8+ to run. It has been installed as 'APKEditor'.

      Usage:
        APKEditor --help
        APKEditor decode -i /path/to/app.apk -o /path/to/output
        APKEditor encode -i /path/to/decoded -o /path/to/new.apk
    EOS
  end

  test do
    assert_match "APKEditor", shell_output("#{bin}/APKEditor --help", 1)
  end
end
