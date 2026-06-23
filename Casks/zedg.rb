cask "zedg" do
  version "1.7.2"
  name "ZedG"
  desc "Zed Editor (Localized / 汉化版)"
  homepage "https://github.com/x6nux/zed-globalization"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  arch arm: "aarch64", intel: "x86_64"
  on_macos do
    sha256 arm:   "d9be0bb04aa163c771bd3580052eabc05397aeca0a6bcc5440cc9f9ddb8b26e4",
           intel: "a58f93a0b4dde9eafbe719bf64e4cfce2546cbb17d665ff5786eaec07dddac9d"

    url "https://github.com/x6nux/zed-globalization/releases/download/v#{version}/zedg-zh-cn-macos-#{arch}-v#{version}.dmg"

    app "ZedG.app"

    postflight do
      system_command "/usr/bin/xattr",
                     args: ["-rd", "com.apple.quarantine", "#{appdir}/ZedG.app"]
    end

    zap trash: [
      "~/Library/Application Support/Zed",
      "~/Library/Caches/dev.zed.ZedG",
      "~/Library/Preferences/dev.zed.ZedG.plist",
      "~/Library/Saved Application State/dev.zed.ZedG.savedState",
    ]
  end

  on_linux do
    sha256 arm:   "c1c173446092d999808969904a5434db7577c5c8d39016ff96e0ac05b9584249",
           intel: "4302f92f9a5d4a7faaf4c1e95d4b005a83b9ec8bff67c1b85da85eb742a2df48"

    url "https://github.com/x6nux/zed-globalization/releases/download/v#{version}/zedg-zh-cn-linux-#{arch}-v#{version}.tar.gz"

    binary "ZedG"
  end

end
