cask "zedg" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.8.2"
  sha256 arm:          "db4194054771e347da2ca85286e85abc4a98afd869c79a3007eb178e602f9fb1",
         x86_64:       "6713c5791b7dd2ab2b5e8f66c201a256b227e591e034422034acffa87bc17fce",
         arm64_linux:  "c1f4466c5cd2d0a379d9b117160ae3ce94e453bd960810c88effec72b31a0911",
         x86_64_linux: "28f561d824a27b41bc6d63166f559d1fe0619d6107ded3014440a6da812a4273"

  url "https://github.com/x6nux/zed-globalization/releases/download/v#{version}/zedg-zh-cn-#{os}-#{arch}-v#{version}.#{on_macos { "dmg" } || "tar.gz"}"
  name "ZedG"
  desc "Zed Editor (Localized / 汉化版)"
  homepage "https://github.com/x6nux/zed-globalization"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
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
    binary "ZedG", target: "zedg"
  end
end
