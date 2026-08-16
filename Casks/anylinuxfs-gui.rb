cask "anylinuxfs-gui" do
  version "0.7.5"

  on_macos do
    # Upstream publishes a single Apple Silicon-only DMG, named
    # "anylinuxfs-gui_<version>_aarch64.dmg".
    arch arm: "aarch64"

    sha256 arm: "701118b5d04368a5153fa0f39d4fb78206509f409d6088797802efbab462fa3f"

    url "https://github.com/fenio/anylinuxfs-gui/releases/download/v#{version}/anylinuxfs-gui_#{version}_#{arch}.dmg"

    app "anylinuxfs-gui.app"

    # The upstream release is ad-hoc signed; without removing the Homebrew
    # quarantine attribute macOS reports the bundle as "damaged".
    postflight do
      system_command "xattr",
                     args: ["-dr", "com.apple.quarantine", appdir/"anylinuxfs-gui.app"]
    end

    zap trash: [
      "~/Library/Application Support/com.anylinuxfs.gui",
      "~/Library/Caches/com.anylinuxfs.gui",
      "~/Library/Logs/com.anylinuxfs.gui",
      "~/Library/Preferences/com.anylinuxfs.gui.plist",
      "~/Library/Saved Application State/com.anylinuxfs.gui.savedState",
    ]
  end

  name "anylinuxfs-gui"
  desc "Graphical frontend for mounting Linux filesystems"
  homepage "https://github.com/fenio/anylinuxfs-gui"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on macos: :big_sur
end
