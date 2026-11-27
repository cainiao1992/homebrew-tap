cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.5"
  sha256 arm:   "853f006ea1b35fb3279e072f710dff3a9c8d503c9f511377db40408438e9db88",
         intel: "dd6353869a4ec4e7c2f3b94f3daf9359697e92d0d64e571d964f5b49d7fde216"

  url "https://github.com/throneproj/Throne/releases/download/#{version}/Throne-#{version}-macos-#{arch}.zip"
  name "Throne"
  desc "Cross-platform GUI proxy utility powered by sing-box"
  homepage "https://throneproj.github.io/"

  livecheck do
    url "https://github.com/throneproj/Throne/releases"
    strategy :github_latest
  end

  # The upstream release is ad-hoc signed; without removing the Homebrew
  # quarantine attribute macOS reports the bundle as "damaged".
  depends_on :macos

  # The release zip nests the bundle under a "Throne/" directory.
  app "Throne/Throne.app"

  postflight_steps do
    run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Throne.app"]
  end

  zap trash: [
    "~/Library/Application Support/moe.Throne.macosx",
    "~/Library/Caches/moe.Throne.macosx",
    "~/Library/Logs/moe.Throne.macosx",
    "~/Library/Preferences/moe.Throne.macosx.plist",
    "~/Library/Saved Application State/moe.Throne.macosx.savedState",
  ]
end
