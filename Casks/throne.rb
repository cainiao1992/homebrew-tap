cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.2"
  sha256 arm:   "c56b99af9153e09ad152b42cfd2975027a097a364ddc65f66f8ea6c4476f4c0d",
         intel: "b7ef9f8a2a0c8b8f798ae03bb76479ce2f24f835e0ee440a6beaa3e9ed2df938"

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
