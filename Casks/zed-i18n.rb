cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.18.1-i18n.3"
  # As of 1.15.0-i18n.2 upstream ships language-agnostic universal builds
  # ("Zed-i18n-macos-<arch>.dmg" / "zed-i18n-linux-<arch>.tar.gz") that bundle
  # all locales, so the previous per-language assets are gone.
  sha256 arm:          "7c441b7c4bde5ed14b23849c57c5abc0866a7fe6ae12101ac38b8b7b593d69e2",
         intel:        "8f79e48dfac01edb1ee324e02f8a1e1bb442ac617200a18fee351dc07c83d49f",
         arm64_linux:  "3361ccf31cd7e48aaec909a1563aff6c789b4cf489cb1939c5470e346844b377",
         x86_64_linux: "cad4f3dfc9bcdf04237252720939c6cb7799429d937ee370d44f71be18dc4dbd"

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
