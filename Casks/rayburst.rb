cask "rayburst" do
  version "4.1.0"
  sha256 arm:          "94d10fb28b9cb0d02acd562ca45beba426d8f58dd777a492c5bdab5c73ea0d60",
         intel:        "8e03ec541881a677b3a3c46101563bdaa83d850a1be983293897d904d26b4a58",
         arm64_linux:  "54f7266fa191622e63346a0c54a9f6a53115338b40fe698c12a5bd521be55f91",
         x86_64_linux: "12818cd15a1f6cde9ea79ec539096de15ea93c14c6ece5fba31222406dce63ba"

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
