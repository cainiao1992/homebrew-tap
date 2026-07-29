cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.12.1-i18n.1"

  language "zh", "CN", default: true do
    sha256 arm:          "41732c0aa8b7d1d0a7a2b92df938877b317ebca6f81e030447abe14195ecb9bf",
           intel:        "41aeac91c5cdac6841202b1ff2458c1cd1c9d293f5c6258b444e84ee4e1c9147",
           arm64_linux:  "30a511b2f6e5cb63dd8cbf1cb98e36ec845da6de1f774f43b7228abc1c5a8869",
           x86_64_linux: "f7e6c78fc0ead95a18d9ba1f40baa2e531ba453e9195cdc30d742c9b2bc0d15a"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "047dc512353fd7eae6b122bb17d075bd754426e9b45b92cc363dddf9fe028fd0",
           intel:        "6ae8308745e6437210e3dc4c18e0bcdd1ad451e678c8794f9fd8cc1fb3df22e1",
           arm64_linux:  "93b3f6ba4bc55d49f6c24a78a779ec57ea101d96657911ad830abe4cade89804",
           x86_64_linux: "1477509e4440cee8d83ad9c569e28f6f660424856d52ba9d2172931ca5dede29"
    "zh-TW"
  end

  # macOS ships "Zed-i18n-<lang>-macos-<arch>.dmg"; Linux ships "zed-i18n-<lang>-linux-<arch>.tar.gz".
  url "https://github.com/LI-NA/zed-i18n/releases/download/v#{version}/" \
      "#{on_macos { "Zed-i18n" } || "zed-i18n"}-#{language}-#{os}-#{arch}." \
      "#{on_macos { "dmg" } || "tar.gz"}"
  name "Zed"
  desc "Localized build of the Zed editor"
  homepage "https://github.com/LI-NA/zed-i18n"

  livecheck do
    url :homepage
    strategy :github_latest
    regex(/v?(\d+\.\d+\.\d+-i18n\.\d+)/i)
  end

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
end
