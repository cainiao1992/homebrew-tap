cask "xapkdetector" do
  version "0.03"
  name "XAPKDetector"
  desc "APK/DEX detector for Windows, Linux and macOS"
  homepage "https://github.com/horsicq/XAPKDetector"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    sha256 "11a231ec845eab502020643fedfeef8582ccd175bcd20256a1bf02c4100d4bae"
    url "https://github.com/horsicq/XAPKDetector/releases/download/#{version}/xapkdetector_mac_portable_#{version}.zip"

    app "XAPKD.app"
  end

  on_linux do
    sha256 "f32097684929836b53348a50cf99760b7f8a1a06db08724b08f5dea3f14d2db8"
    url "https://github.com/horsicq/XAPKDetector/releases/download/#{version}/XAPKDetector-#{version}-x86_64.AppImage"

    depends_on arch: :x86_64

    binary "XAPKDetector-#{version}-x86_64.AppImage", target: "xapkdetector"
  end
end
