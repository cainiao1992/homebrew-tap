cask "rayburst" do
  version "4.1.1"
  sha256 arm:          "715ed7f6eaf5a79e06d554f365a313b4843f90493f09b157091a15d665253b24",
         intel:        "edd26d4a9b834d161531151b7a44f3d81da4209f3059194d43f18ea8c8d4af91",
         arm64_linux:  "6f9a439ca478b52b81bd5d98277d878b1530c34a32aa5e54a1de7d137fa640ce",
         x86_64_linux: "2f9e2b0cb92cc21b6f0a9bc87345a1b78ef1eadb35efe653d6e03be90d5ccbdb"

  on_macos do
    # Upstream ships separate per-architecture DMGs rather than a universal one.
    arch arm: "aarch64", intel: "x64"

    url "https://github.com/AnInsomniacy/rayburst/releases/download/v#{version}/Rayburst_#{version}_#{arch}.dmg"

    app "Rayburst.app"

    # The upstream bundle is ad-hoc signed and not notarized; without removing
    # the Homebrew quarantine attribute macOS reports the app as "damaged".
    postflight_steps do
      run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Rayburst.app"]
    end

    # Browser integration registers a native messaging host in each supported
    # browser; these are the app's own manifest files, not the profile itself.
    zap trash: [
      "~/Library/Application Support/dev.aninsomniacy.rayburst",
      "~/Library/Application Support/Google/Chrome/NativeMessagingHosts/dev.aninsomniacy.rayburst.browser.json",
      "~/Library/Application Support/Mozilla/NativeMessagingHosts/dev.aninsomniacy.rayburst.browser.json",
      "~/Library/Caches/dev.aninsomniacy.rayburst",
      "~/Library/Logs/dev.aninsomniacy.rayburst",
      "~/Library/WebKit/dev.aninsomniacy.rayburst",
    ]
  end
  on_linux do
    # Linux AppImages use the "amd64" suffix where macOS uses "x64".
    arch arm: "aarch64", intel: "amd64"

    url "https://github.com/AnInsomniacy/rayburst/releases/download/v#{version}/Rayburst_#{version}_#{arch}.AppImage"

    # The target stays version-less: the bundled Tauri updater overwrites the
    # installed AppImage in place, so a versioned name would dangle.
    app_image "Rayburst_#{version}_#{arch}.AppImage", target: "Rayburst.AppImage"
  end

  name "Rayburst"
  desc "Download manager with BitTorrent, media, and browser integration"
  homepage "https://github.com/AnInsomniacy/rayburst"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  # The app bundles the Tauri updater (tauri-plugin-updater) pointed at its own
  # release channel, so it updates itself.
  auto_updates true
end
