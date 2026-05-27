cask "xpeviewer" do
  version "0.05"
  name "XPEViewer"
  desc "PE file viewer and editor for Windows, Linux and macOS"
  homepage "https://github.com/horsicq/XPEViewer"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    sha256 "68d09a2efff04158c3a633852ff03b6d77e929d90c49240eb9eaaaedf54b19f1"
    url "https://github.com/horsicq/XPEViewer/releases/download/#{version}/xpeviewer_mac_portable_#{version}_x86_64.zip"

    depends_on arch: :x86_64

    app "XPEViewer.app"

    caveats do
      requires_rosetta
    end
  end

  on_linux do
    sha256 "ca88cbfced07d847820cd6981103cd8b8d811c29f45b018ec9d5e4e5b73ee28d"
    url "https://github.com/horsicq/XPEViewer/releases/download/#{version}/XPEViewer-#{version}-x86_64.AppImage"

    depends_on arch: :x86_64

    binary "XPEViewer-#{version}-x86_64.AppImage", target: "xpeviewer"
  end
end
