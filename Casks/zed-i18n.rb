cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.25.3-i18n.1"
  # As of 1.15.0-i18n.2 upstream ships language-agnostic universal builds
  # ("Zed-i18n-macos-<arch>.dmg" / "zed-i18n-linux-<arch>.tar.gz") that bundle
  # all locales, so the previous per-language assets are gone.
  sha256 arm:          "04095e12be54f49101a171c8cb1c71e8f66e12b5ac416120e81b82f3d6698097",
         intel:        "0202145a9a6a598f061cf3d7793b7a70f86f663ca1f764494da142b8e5102da4",
         arm64_linux:  "33354ac89706bcb3ac005c67f28487619e1a6d813d2b03e8dc7dcb1e93f7940b",
         x86_64_linux: "0ffcb9ecb5edf24ed906051588147e301e8ae9603f1679d726ad3088f3a20f8d"

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
