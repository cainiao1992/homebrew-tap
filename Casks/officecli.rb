cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.108"
  sha256 arm:          "7a58472396a1a44b1a5bdd4b46d302cb798ce1b15f412f9e76c37b5e146587a8",
         x86_64:       "778173ea29d2533c3b92cfb2f5c3184deba9928e3fd870d8cb9e44901f1e599a",
         arm64_linux:  "904f335db3bbd0b24a74d87a44bc6adefa911c943d445ffb72989c3d7c66bd68",
         x86_64_linux: "a6b020f8ef97f3eb4245d2a3bac3d4cf1fea8305c1031d4b67d53780f0317215"

  url "https://github.com/iOfficeAI/OfficeCLI/releases/download/v#{version}/officecli-#{os}-#{arch}"
  name "OfficeCLI"
  desc "AI-friendly CLI for Office documents (.docx, .xlsx, .pptx)"
  homepage "https://github.com/iOfficeAI/OfficeCLI"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  binary "officecli-#{os}-#{arch}", target: "officecli"
end
