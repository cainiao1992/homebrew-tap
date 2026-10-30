cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.26.2-i18n.1"
  # As of 1.15.0-i18n.2 upstream ships language-agnostic universal builds
  # ("Zed-i18n-macos-<arch>.dmg" / "zed-i18n-linux-<arch>.tar.gz") that bundle
  # all locales, so the previous per-language assets are gone.
  sha256 arm:          "c87e0ea19875b4a377a67d7f54b9cd56c44da0585f50d3ef7136fd75cb888165",
         intel:        "dc5fd7304809134ccf46eecdadba919c3e0a961ebc46c44f858714d1991a1216",
         arm64_linux:  "2a59beec40858a6745d309173e5f11994ef6172bbe777fe9bd88072e1c3f3233",
         x86_64_linux: "9b25a9b974eada20007c9609d7188f0a02b06a7f05116e90d605e56e8af19b36"

  on_macos do
    # The DMG ships as "Zed i18n.app"; install it as "Zed.app" for consistency
    # with the official Zed installation so Spotlight and integrations find it.
    app "Zed i18n.app", target: "Zed.app"
    binary "#{appdir}/Zed.app/Contents/MacOS/cli", target: "zed"

    # Upstream ships the app ad-hoc signed; without removing the Homebrew
    # quarantine attribute macOS reports the bundle as "damaged".
    postflight_steps do
      run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Zed.app"]
    end

    zap trash: [
      "~/Library/Application Support/Zed",
      "~/Library/Caches/Zed",
      "~/Library/Logs/Zed",
      "~/Library/Preferences/dev.zed-i18n.Zed.plist",
      "~/Library/Saved Application State/dev.zed-i18n.Zed.savedState",
    ]
  end
  on_linux do
    binary "zed.app/bin/zed", target: "zed"
  end

  # macOS ships "Zed-i18n-macos-<arch>.dmg"; Linux ships "zed-i18n-linux-<arch>.tar.gz".
  url "https://github.com/LI-NA/zed-i18n/releases/download/v#{version}/" \
      "#{on_macos { "Zed-i18n" } || "zed-i18n"}-#{os}-#{arch}." \
      "#{on_macos { "dmg" } || "tar.gz"}"
  name "Zed"
  desc "Localized build of the Zed editor"
  homepage "https://github.com/LI-NA/zed-i18n"

  livecheck do
    url :homepage
    strategy :github_latest
    regex(/v?(\d+\.\d+\.\d+-i18n\.\d+)/i)
  end
end
