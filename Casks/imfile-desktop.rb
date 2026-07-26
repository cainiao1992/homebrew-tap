cask "imfile-desktop" do
  version "2.1.0"

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

    sha256 arm:   "c3977986c2ca35f6db0ac8e6dad29a4c5e0c5462af2a3209798c8cf400d0f84a",
           intel: "840da82a49424432844b9a681f8ac06a1386018c17ad426d272bfb0de4b71be8"

    url "https://github.com/imfile-io/imfile-desktop/releases/download/v#{version}/imFile-#{version}-#{arch}.zip"

    app "imFile.app"

    # The upstream release is ad-hoc signed; without removing the Homebrew
    # quarantine attribute macOS reports the bundle as "damaged".
    postflight do
      system_command "xattr",
                     args: ["-dr", "com.apple.quarantine", appdir/"imFile.app"]
    end
  end

  on_linux do
    # Linux ships "imFile-<version>-arm64.AppImage" (aarch64) and
    # "imFile-<version>.AppImage" (x86_64).
    arch arm: "arm64"

    sha256 arm:   "fadf85bd9c212601d056cef524b0c32758036d8ab66e4b05e8deba7c8dcf3e4b",
           intel: "63fa8ebf19458b3ab0f70cffdaebd842bbd15121bcb16fd10da239f144acb4ab"

    url "https://github.com/imfile-io/imfile-desktop/releases/download/v#{version}/imFile-#{version}#{arch}.AppImage"

    appimage "imFile-#{version}#{arch}.AppImage"
  end

  zap trash: [
    "~/Library/Application Support/app.imfile.native",
    "~/Library/Caches/app.imfile.native",
    "~/Library/Logs/app.imfile.native",
    "~/Library/Preferences/app.imfile.native.plist",
    "~/Library/Saved Application State/app.imfile.native.savedState",
  ]
end
