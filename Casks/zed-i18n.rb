cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.11.3-i18n.1"

  language "zh", "CN", default: true do
    sha256 arm:          "e59c567d071d993fd0aef2de979e1c88cc8f51c71b2770f705e8e3bb93e46c57",
           intel:        "c48de44a8f2f6833ad57ae933b7058af0eb504ebc201cb93e4ef81239f67c8e2",
           arm64_linux:  "46c194969dc06b11dc51814e8ec8a1e0c5e889578e16ce411db5b1d730498541",
           x86_64_linux: "775314822fe3385cdcd18e0a0e66e17038e35f9c68f9020c8da281f7d73d48c0"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "9a8cebef3fd2fc32eb2256b28b7eab006b613e6634bf5322f18a7c8c7418b040",
           intel:        "82aa0ef19dd8a4528868815bda33495af34dd378f4c1957167e1b1c53f28cc94",
           arm64_linux:  "71dfe92e69fcd20849d98bf254cee50ef903d7ab9a09b8817fd9f0dcbc191bab",
           x86_64_linux: "9f582df05b56e09278dcaaff1684fb3af93980e7c3f0b5e314ae8c11c35c46fe"
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
