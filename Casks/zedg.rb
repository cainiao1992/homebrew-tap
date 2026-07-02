cask "zedg" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "1.9.0"
  sha256 arm:          "79246c165e0aec4ac5a9615b04953212ba99fe175bc6e569957e7b4dc2fb16f9",
         x86_64:       "bf21a89510d699078bdc6814ec55cceaa6282dc020366f90540a03a29dae6a2d",
         arm64_linux:  "ed6f0042fbc235a0d412a2e15b415f75de610e991d492c8966d531c4f1b258df",
         x86_64_linux: "48f1ec29723c468fb1786ff93edff284151d6bf398839fbe86599e84f8543a7e"

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
