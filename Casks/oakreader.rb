cask "oakreader" do
  version "0.7.15"
  sha256 "95fe4333cdeac8c9e2410c28fc2df87a558e205739b72c5853485e3d30153ea4"

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
