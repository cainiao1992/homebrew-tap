class Apkeditor < Formula
  desc "APK editor for parsing, decoding, and editing Android APK files"
  homepage "https://github.com/REAndroid/APKEditor"
  url "https://github.com/REAndroid/APKEditor/releases/download/V1.4.9/APKEditor-1.4.9.jar"
  sha256 "a9cd40df818845456be6d696de6110c89edf4b0a0580cb83438ed6b25a366e67"
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
