cask "apk-editor-studio" do
  version "1.7.2"
  name "APK Editor Studio"
  desc "Powerful yet easy to use APK editor for PC and Mac"
  homepage "https://github.com/kefir500/apk-editor-studio"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    sha256 "b6e720840bc79ea22fedd48185ef6ff877223a2970b636c8b0dcea4820b6d5a0"
    url "https://github.com/kefir500/apk-editor-studio/releases/download/v#{version}/apk-editor-studio_macos_#{version}.app.zip"

    app "APK Editor Studio.app"
  end

  on_linux do
    sha256 "4b20d5ea5fd9cfab3810600c9b1c07398705d90ef4a36bba1c9f7f32f7ee7027"
    url "https://github.com/kefir500/apk-editor-studio/releases/download/v#{version}/apk-editor-studio_linux_#{version}.AppImage"

    binary "apk-editor-studio_linux_#{version}.AppImage", target: "apk-editor-studio"
  end
end
