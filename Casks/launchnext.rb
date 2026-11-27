cask "launchnext" do
  version "2.4.2"
  sha256 "647c67cb94ec7b1d91ca612824eabf5bbc4cc81fbb02913bedb6919d4262645d"

  url "https://github.com/RoversX/LaunchNext/releases/download/#{version}/LaunchNext#{version}.zip"
  name "LaunchNext"
  desc "Customizable Launchpad replacement"
  homepage "https://closex.org/launchnext/"

  livecheck do
    url "https://github.com/RoversX/LaunchNext"
    strategy :github_latest
  end

  # The app checks the GitHub releases API and updates itself in place.
  auto_updates true
  depends_on macos: :tahoe

  app "LaunchNext.app"

  # Homebrew quarantines the copy in /Applications; strip it so Gatekeeper
  # does not block the first launch.
  postflight_steps do
    run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/LaunchNext.app"]
  end

  # Verified after a real launch: the app stores its database under Application
  # Support and keeps cache and HTTP storage keyed by its own name/bundle ID.
  zap trash: [
    "~/Library/Application Support/LaunchNext",
    "~/Library/Caches/LaunchNext",
    "~/Library/HTTPStorages/com.roversx.launchnext",
    "~/Library/Preferences/com.roversx.launchnext.plist",
    "~/Library/Saved Application State/com.roversx.launchnext.savedState"，
  ]
end
