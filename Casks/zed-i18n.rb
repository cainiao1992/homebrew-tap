cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.12.0-i18n.1"

  language "zh", "CN", default: true do
    sha256 arm:          "2e829d9a5a1d6ee386ef04c856ea720a52ee7316e138b40592a4f11d77c538ca",
           intel:        "66f4b3eab16fe6230071f3238f5c049b2df0073357ef985a6ad5026f12a8f8cb",
           arm64_linux:  "6242f609c36b3f5af7641121a993fa9dde7e8375a6a2ba598748c2b0cb62ab50",
           x86_64_linux: "0b4c64c1a290eef92392fee40e10cdd836ae42c9e0b51f01de5f031628b829be"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "975f1b2ab9b3ddf132dc456906975b010a937982a868df04f8b7aa0255ea62ae",
           intel:        "c2a27bcdafba4bc16d5a67acbd41a46d86e29120e11263d3fea6c78a5273aa0d",
           arm64_linux:  "d9ca8f9c7f472ec3547959143eff50e0c3a54dda34a1841b638dc0e0b3b0e8d7",
           x86_64_linux: "ee60e6b7984b8837efedd4690bc98a59aad9188c142ccbb8e5f39cf56337c189"
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
