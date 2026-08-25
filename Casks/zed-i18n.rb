cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.16.2-i18n.1"
  # As of 1.15.0-i18n.2 upstream ships language-agnostic universal builds
  # ("Zed-i18n-macos-<arch>.dmg" / "zed-i18n-linux-<arch>.tar.gz") that bundle
  # all locales, so the previous per-language assets are gone.
  sha256 arm:          "3d206f42568206d97b446ceebc6088f4f25b4a6129aab97478bc37b68769dbce",
         intel:        "a36c610f8af4578285965e71c5c223777c0ef1e8fd943b507980c84277c753e8",
         arm64_linux:  "86bd6d6bd9eaaa44d4c9d071ed1034fb764a2a0759f6c14c8f68ed38fc67fa60",
         x86_64_linux: "d67a5a9dbfb6f3e6b385b9a1941575f39ff27c49286ccb7d06b11a8f129dc1e5"

  on_macos do
    # The DMG ships as "Zed i18n.app"; install it as "Zed.app" for consistency
    # with the official Zed installation so Spotlight and integrations find it.
    app "Zed i18n.app", target: "Zed.app"
    binary "#{appdir}/Zed.app/Contents/MacOS/cli", target: "zed"

    # Strip debug symbols to shrink the binary on disk (~94 MB smaller).
    # strip invalidates the app's code signature, so we must re-sign.
    # Prefer a local Developer ID certificate (if available) over ad-hoc signing
    # to preserve Keychain access permissions across updates.
    postflight do
      app = "#{appdir}/Zed.app"
      binary = "#{app}/Contents/MacOS/zed"
      cli_binary = "#{app}/Contents/MacOS/cli"
      entitlements = "#{app}/Contents/Resources/zed.entitlements"

      system_command "strip", args: ["-x", binary] if File.exist?(binary)
      system_command "strip", args: ["-x", cli_binary] if File.exist?(cli_binary)

      # Find any code signing certificate; fallback to ad-hoc ("-") if none exists.
      # A fixed certificate preserves Keychain access permissions across updates.
      security_output = system_command("security",
                                       args: ["find-identity", "-v", "-p", "codesigning"]).stdout
      cert_id = security_output.scan(/\(([A-Z0-9]+)\)/).flatten.first || "-"

      if File.exist?(entitlements)
        system_command "codesign",
                       args: ["--force", "--deep", "--sign", cert_id, "--entitlements", entitlements, app]
      else
        system_command "codesign", args: ["--force", "--deep", "--sign", cert_id, app]
      end
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
