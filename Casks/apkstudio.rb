cask "apkstudio" do
  version "6.3.0"
  name "Apk Studio"
  desc "Cross-platform Qt IDE for reverse-engineering Android application packages"
  homepage "https://github.com/vaibhavpandeyvpz/apkstudio"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    sha256 "5fbeebc2454eb1c08e4d490d4097111bcd5d46358b0db8f412a200a2a7133c15"
    url "https://github.com/vaibhavpandeyvpz/apkstudio/releases/download/v#{version}/ApkStudio-macOS-x64.dmg"

    depends_on arch: :x86_64

    app "APK Studio.app"

    caveats do
      requires_rosetta
    end
  end

  on_linux do
    sha256 "2c7ce8cb1a1b138468bd8da1690ec23a18422205dc07a311b8ec16a228ef8df6"
    url "https://github.com/vaibhavpandeyvpz/apkstudio/releases/download/v#{version}/ApkStudio-v#{version}-x86_64.AppImage"

    depends_on arch: :x86_64

    binary "ApkStudio-v#{version}-x86_64.AppImage", target: "apkstudio"
  end
end
