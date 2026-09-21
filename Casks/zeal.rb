cask "zeal" do
  arch arm: "arm64"

  version "0.0.0-bootstrap"
  sha256 arm: "0000000000000000000000000000000000000000000000000000000000000000"

  # Upstream ships no macOS binaries; the zip is built by build-zeal.yml and
  # published as a tap release. The url interpolates the version line.
  url "https://github.com/cainiao1992/homebrew-tap/releases/download/zeal-#{version}/Zeal-#{version}-macos-#{arch}.zip"
  name "Zeal"
  desc "Offline documentation browser"
  homepage "https://zealdocs.org"

  livecheck do
    skip "Built from source by build-zeal.yml; releases are cut by CI"
  end

  depends_on arch: :arm64

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
