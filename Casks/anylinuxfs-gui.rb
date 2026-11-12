cask "anylinuxfs-gui" do
  version "0.8.3"

  on_macos do
    # Upstream publishes a single Apple Silicon-only DMG, named
    # "anylinuxfs-gui_<version>_aarch64.dmg".
    arch arm: "aarch64"

    sha256 arm: "74f96ee058c14a720471209cd3a25eb1d56fca04eaca9835a8d1ac833d89576e"

    url "https://github.com/fenio/anylinuxfs-gui/releases/download/v#{version}/anylinuxfs-gui_#{version}_#{arch}.dmg"

    app "anylinuxfs-gui.app"

    # The upstream release is ad-hoc signed; without removing the Homebrew
    # quarantine attribute macOS reports the bundle as "damaged".
    postflight_steps do
      run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/anylinuxfs-gui.app"]
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

  # Upstream only ships an Apple Silicon build; without the arch constraint
  # `brew bump-cask-pr` fails on the missing intel checksum.
  depends_on arch: :arm64
  depends_on :macos
end
