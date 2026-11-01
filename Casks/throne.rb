cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.3.2"
  sha256 arm:   "c5371633f17e46d18d999206a79bafe4ec1b20e03acf51171261f3084b702b16",
         intel: "b5312bd4b6aceb5d2107be06fb6a407ec4da5159c5da0b428ac26c784bf404a9"

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
