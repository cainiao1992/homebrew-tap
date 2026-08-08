cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.14.2-i18n.1"

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
    sha256 arm:          "e1cb1381c3d4689c6029397c459782b72130a92765f94025d183494beacec31f",
           intel:        "e83b0133d647ab40b890cb2d616b8236c71f61ee40a5499e5b5e96fd5be39fd0",
           arm64_linux:  "e4522bc607925869496de526638777bb8ec49961a6e050854d136f878a76c474",
           x86_64_linux: "21b1c0ae0ce2bbd9eda918c2778f8507bc93a27941201a0081d53bca4019ffda"
    "zh-CN"
  end
  language "zh", "TW" do
    sha256 arm:          "2c80ac4d58e89d46c38f18938e8ce7288d31352d092155ee934907b7234b26b4",
           intel:        "a363b9cd34518826470cf442e20e637c5402afe7c8965e005863cf08e8d08fdc",
           arm64_linux:  "896c4bae502054430967449321e6149eee854a8a4684e1002e1fac4c25bf6df8",
           x86_64_linux: "06eb4e6920a9647299ccbe578b7511e4d99373e0c4c250c6a493bb1eee3eaecc"
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
