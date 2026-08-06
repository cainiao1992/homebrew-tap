cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.13.2-i18n.1"

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

  language "zh", "CN", default: true do
    sha256 arm:          "ec1eabce94e346efe5edee5566e6e0efb1ea844c8393b95c192ec3e6631b4994",
           intel:        "91d597bf9b994695dc561f4521f78d134ae8b8028cc4d1888bf00ca33a824a98",
           arm64_linux:  "c5607baa29fb7bfc8787fda73b168d0f680bdadf575b290507b5ae2b5ba68d9c",
           x86_64_linux: "1b23ba9e18891d29c71f9233394cc590e5cc482fe0e103597f8fbc793ee269ab"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "905b4ce0c3eaac79899235901b9a53df7673b7a894959637dc10695bb103ced7",
           intel:        "4e7807807c0504d0e1bc28a78c9ae62e4b4f6b740fa32170b53fc77c8be6fb61",
           arm64_linux:  "e1b2503810456f6c573de4543487b304bbed3c1cc893eedf0fd9e82dd872580a",
           x86_64_linux: "33555891fe284caad32fda6203fc062b3f7c099046560e5bb930c3175c4ee342"
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
end
