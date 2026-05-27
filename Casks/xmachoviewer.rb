cask "xmachoviewer" do
  version "0.04"
  name "XMachOViewer"
  desc "Mach-O file viewer and editor for Windows, Linux and macOS"
  homepage "https://github.com/horsicq/XMachOViewer"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    sha256 "7924a7bcbb48f3f63e76df4657954a80bca770dd0b95058c4498dcf5b1c1e72f"
    url "https://github.com/horsicq/XMachOViewer/releases/download/#{version}/xmachoviewer_mac_portable_#{version}.zip"

    app "xmachoviewer.app"
  end

  on_linux do
    sha256 "04f9519034ea036a0984af90f02b319efb5b796029c1b287bc38a59a5bf9368a"
    url "https://github.com/horsicq/XMachOViewer/releases/download/#{version}/XMachOViewer-#{version}-x86_64.AppImage"

    depends_on arch: :x86_64

    binary "XMachOViewer-#{version}-x86_64.AppImage", target: "xmachoviewer"
  end
end
