cask "oakreader" do
  version "0.18.2"
  sha256 "1212cd4d8f47d3b2158cc814d016128fd0545bcf143b1e46a419bf1e47dae3b4"

  # Upstream ships a single universal (arm64 + x86_64) DMG on its own CDN, not
  # on the GitHub releases page, which carries no assets.
  url "https://downloads.oakreader.com/oakreader/v#{version}/OakReader.dmg"
  name "OakReader"
  desc "AI reader and knowledge library for PDFs, papers and web pages"
  homepage "https://oakreader.com/"

  # The app bundles Sparkle, so version discovery goes through its appcast
  # rather than the asset-less GitHub releases.
  livecheck do
    url "https://downloads.oakreader.com/oakreader/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "OakReader.app"

  # Both support directories are real: the bundled `oak` CLI resolves the
  # library from the unbranded path, while the app itself writes the library and
  # its telemetry under the bundle identifier.
  zap trash: [
    "~/Library/Application Support/com.oakreader.OakReader",
    "~/Library/Application Support/OakReader",
    "~/Library/Caches/com.oakreader.OakReader",
    "~/Library/HTTPStorages/com.oakreader.OakReader",
    "~/Library/Preferences/com.oakreader.OakReader.plist",
    "~/Library/Saved Application State/com.oakreader.OakReader.savedState",
  ]
end
