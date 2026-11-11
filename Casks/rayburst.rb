cask "rayburst" do
  version "4.1.2"
  sha256 arm:          "ed54a1d1bf0d4b0819aa24c7ee4c662f5e1e1e4555ef48f8e6299a3ea8cc6d1c",
         intel:        "c9892990659893bba7737eb68daf801864a861e8e180f3ef9987ebeb3c9f1c8a",
         arm64_linux:  "ec0fd742aac2bae558796748514f83c97ff9bf2fa946ae119a45b05445dd45dc",
         x86_64_linux: "84f3cc8797ec03119f7049b50ee151dcba74c55d21f26496f63d6b781fb4a52d"

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
