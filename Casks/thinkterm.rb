cask "thinkterm" do
  arch arm: "arm64", intel: "x86_64"

  version "0.6.2"
  sha256 arm:   "904b9b68864fd4fdee91191afa47705c77561b7d0050cccd3ffad2081604105a",
         intel: "11122823b8a47d8a27307f4f5addd021e3b80db3d3d4b0b9fff4a940c919b87b"

  url "https://github.com/RoversX/ThinkTerm/releases/download/#{version}/ThinkTerm-macos-#{arch}-#{version}.zip"
  name "ThinkTerm"
  desc "Workspace-first terminal"
  homepage "https://closex.org/thinkterm/"

  livecheck do
    url "https://github.com/RoversX/ThinkTerm"
    strategy :github_latest
  end

  # The app checks GitHub releases and updates itself.
  auto_updates true
  conflicts_with cask: ["wezterm", "wezterm@nightly"]
  depends_on macos: :sonoma

  app "ThinkTerm-macos-#{arch}-#{version}/ThinkTerm.app"
  binary "#{appdir}/ThinkTerm.app/Contents/MacOS/thinkterm"
  binary "#{appdir}/ThinkTerm.app/Contents/MacOS/wezterm"
  binary "#{appdir}/ThinkTerm.app/Contents/MacOS/thinkterm-gui"
  binary "#{appdir}/ThinkTerm.app/Contents/MacOS/thinkterm-mux-server"
  binary "#{appdir}/ThinkTerm.app/Contents/MacOS/strip-ansi-escapes"

  # Homebrew quarantines the copy in /Applications; strip it so Gatekeeper
  # does not block the first launch.
  postflight_steps do
    run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ThinkTerm.app"]
  end

  # Paths appeared after a real launch, except the saved-state entry, which
  # comes from upstream's cask and is only created when window state is saved.
  zap trash: [
    "~/.config/thinkterm",
    "~/.local/share/thinkterm",
    "~/Library/Application Support/ThinkTerm",
    "~/Library/Caches/thinkterm",
    "~/Library/Preferences/com.roversx.thinkterm.plist",
    "~/Library/Saved Application State/com.roversx.thinkterm.savedState",
  ]
end
