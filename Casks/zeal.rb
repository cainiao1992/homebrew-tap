cask "zeal" do
  arch arm: "arm64", intel: "x64"

  version "0.9.2"
  sha256 arm: "4d75989fa9f27ccfbb5e0f7bb2db90ff4f325f9a225739220e48ee47ed7fa774",
         intel: "2a814f963b71a7b24b87ecd945494f2c4e9e53fff5503b67f5322218a4220925"

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
