cask "imfile-desktop" do
  version "2.3.4"

  on_macos do
    # macOS ships "imFile-<version>-arm64-mac.zip" (Apple Silicon) and
    # "imFile-<version>-mac.zip" (Intel); both extract to "imFile.app".
    arch arm: "arm64-mac", intel: "mac"

    sha256 arm:   "b588c862488ae2d7c3772456305d91f757de90305749a368caad3305f21c41d6",
           intel: "8a3fd4be1a16f7d39fd79f63b14e375d4ecb7cf07d835e26fc109360d0a006e1"

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
    sha256 arm64_linux:  "f24d1914cc317938bd3e0e26d3b26bbe20984bbfbcd2a023ca62274bf889f762",
           x86_64_linux: "d241e5bb0f3c5a58e15ecf8cc61c135c1ac07c2a69c8f7e4a6453b05bb074d19"

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
