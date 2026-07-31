cask "imfile-desktop" do
  version "2.2.0"

  name "imFile"
  desc "Full-featured download manager"
  homepage "https://github.com/imfile-io/imfile-desktop"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :monterey

  on_macos do
    # macOS ships "imFile-<version>-arm64-mac.zip" (Apple Silicon) and
    # "imFile-<version>-mac.zip" (Intel); both extract to "imFile.app".
    arch arm: "arm64-mac", intel: "mac"

    sha256 arm:   "befdb4c91f2b7ddb0c8ec0ceb4349376adb9ffd72c0fa83ce2a31873065df8c7",
           intel: "705985041ca290e341eb39c2ed7bb538136bcd0d2091158a60720551d3536dca"

    url "https://github.com/imfile-io/imfile-desktop/releases/download/v#{version}/imFile-#{version}-#{arch}.zip"

    app "imFile.app"

    # The upstream release is ad-hoc signed; without removing the Homebrew
    # quarantine attribute macOS reports the bundle as "damaged".
    postflight do
      system_command "xattr",
                     args: ["-dr", "com.apple.quarantine", appdir/"imFile.app"]
    end

    # macOS-only cleanup paths under ~/Library.
    zap trash: [
      "~/Library/Application Support/app.imfile.native",
      "~/Library/Caches/app.imfile.native",
      "~/Library/Logs/app.imfile.native",
      "~/Library/Preferences/app.imfile.native.plist",
      "~/Library/Saved Application State/app.imfile.native.savedState",
    ]
  end

  on_linux do
    # Linux ships "imFile-<version>-arm64.AppImage" (aarch64) and
    # "imFile-<version>.AppImage" (x86_64).
    arch arm: "-arm64", intel: ""

    sha256 arm:   "9157b4d0e6ea76074add89fe3993aeca355f1723a6c5196552a52c26a0f79052",
           intel: "de5d213fe9928f5b402bfd1c659d18da699dc1f8fa43ba04d7dd002741dcf131"

    url "https://github.com/imfile-io/imfile-desktop/releases/download/v#{version}/imFile-#{version}#{arch}.AppImage"

    app_image "imFile-#{version}#{arch}.AppImage"
  end
end
