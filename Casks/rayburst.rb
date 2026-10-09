cask "rayburst" do
  version "4.0.1"
  sha256 arm:          "f4d1c40d7794dc7f42323001b472b2a722b168ace57e21074b9e780da883b3f2",
         intel:        "2f2e1e56f7db4a5706600314d4a09893341043580281a36f4fa11ae7a94102f2",
         arm64_linux:  "4f0f4430e6286fa6b86e39d7897e04b03e5615e2e0714e4f437c3c1ee3dfcf21",
         x86_64_linux: "009f444219bafb9bb160c2a336ad2afb64b6d3a4b2f015556b3ec11f2e542a56"

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
