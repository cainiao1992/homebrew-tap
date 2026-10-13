cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.23.3-i18n.1"
  # As of 1.15.0-i18n.2 upstream ships language-agnostic universal builds
  # ("Zed-i18n-macos-<arch>.dmg" / "zed-i18n-linux-<arch>.tar.gz") that bundle
  # all locales, so the previous per-language assets are gone.
  sha256 arm:          "1b6f1d78c68e013fe2251603e2247ddc213915c87d70cf44435ec4aae3065ea0",
         intel:        "e81c4f9a5a47e3db6314fa689d1329b6e3e74628d42c3aac950aa73ad592901f",
         arm64_linux:  "f32faa96e76e800c0bb5c9d38bfc716d8853cde14953961f13aeb08b2f6f3fbe",
         x86_64_linux: "43e5ec228b189766bbfad5feb67d8d0cd545db0811f0d6a15e64e86eb946d368"

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
