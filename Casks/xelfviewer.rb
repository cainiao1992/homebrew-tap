cask "xelfviewer" do
  version "0.05"
  name "XELFViewer"
  desc "ELF file viewer and editor for Windows, Linux and macOS"
  homepage "https://github.com/horsicq/XELFViewer"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    sha256 "a1e160a960d90e3a3b8d2de825221b37e78c3cd6851a640d7fa9433ba12d4c46"
    url "https://github.com/horsicq/XELFViewer/releases/download/#{version}/xelfviewer_mac_portable_#{version}.zip"

    app "xelfviewer.app"
  end

  on_linux do
    sha256 "8e4e8c38b004316003410def44364011b16db5e29f3688254c49bb80c9d6b5a5"
    url "https://github.com/horsicq/XELFViewer/releases/download/#{version}/XELFViewer-#{version}-x86_64.AppImage"

    depends_on arch: :x86_64

    binary "XELFViewer-#{version}-x86_64.AppImage", target: "xelfviewer"
  end
end
