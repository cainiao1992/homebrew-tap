cask "throne" do
  arch arm: "arm64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "50766e6563878810c8a43f1e42ae9a79c94c9e2e57122e48a57427d745bcc755",
         intel: "9980a1b8b27e39c184f0e49ca3e51392f39fc1f90a1c93411c90c673748366ac"

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
