cask "zeal" do
  arch arm: "arm64", intel: "x64"

  version "0.9.1"
  sha256 arm: "477949279e372726149cfeb203a9fecded54985cb28e32a559120dfc602fab01",
         intel: "bf831ac238111a600eae973f08526bf0c6d77997d4b9d77e0004a0f73f1c4cdc"

  # Upstream ships no macOS binaries; the tarball is built by build-zeal.yml
  # and published as a tap release. The url interpolates the version line.
  url "https://github.com/cainiao1992/homebrew-tap/releases/download/zeal-#{version}/Zeal-#{version}-macos-#{arch}.tar.xz"
  name "Zeal"
  desc "Offline documentation browser"
  homepage "https://zealdocs.org"

  livecheck do
    skip "Built from source by build-zeal.yml; releases are cut by CI"
  end

  # The bundle is ad-hoc signed; without removing the Homebrew quarantine
  # attribute macOS reports it as "damaged" (same as zed-i18n).
  postflight_steps do
    run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Zeal.app"]
  end

  app "Zeal.app"
  binary "#{appdir}/Zeal.app/Contents/MacOS/Zeal", target: "zeal"

  zap trash: [
    "~/Library/Application Support/Zeal",
    "~/Library/Caches/Zeal",
    "~/Library/Preferences/org.zealdocs.zeal.plist",
    "~/Library/Saved Application State/org.zealdocs.zeal.savedState",
  ]
end
