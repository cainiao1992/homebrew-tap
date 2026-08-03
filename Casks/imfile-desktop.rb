cask "imfile-desktop" do
  version "2.2.1"

  on_macos do
    # macOS ships "imFile-<version>-arm64-mac.zip" (Apple Silicon) and
    # "imFile-<version>-mac.zip" (Intel); both extract to "imFile.app".
    arch arm: "arm64-mac", intel: "mac"

    sha256 arm:   "18b67aec2bc96fe6d125980401e47707d63e44a8c05b378839f3f6db8d92b6e2",
           intel: "d997653f4787695153fa91638ed42064d98d45f99b5f0e34fb1cfa05febcc080"

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
    arch arm: "-arm64"

    # Linux checksums must use the `*_linux` keys; `arm:`/`intel:` only apply to
    # macOS, which would leave `sha256` nil on Linux and break `brew bump-cask-pr`.
    sha256 arm64_linux:  "8ad590021cf88b5aa0de5acf671beaca6cc7e510efd34a366b806320cd48b22c",
           x86_64_linux: "928ed027a326f7f931b3d2c61c3bcff2b44e1e1203f446149b7556fc37da7ce0"

    url "https://github.com/imfile-io/imfile-desktop/releases/download/v#{version}/imFile-#{version}#{arch}.AppImage"

    app_image "imFile-#{version}#{arch}.AppImage"
  end

  name "imFile"
  desc "Full-featured download manager"
  homepage "https://github.com/imfile-io/imfile-desktop"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :monterey
end
