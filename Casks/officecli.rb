cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.128"
  sha256 arm:          "fe9a23771925728359d891f8dcc999aec0023df95df068f9b4e96d06a43634ef",
         x86_64:       "0ce3fe11fb938690d1b043e857d9103a6128124d48f433db302f1f937ea6b5a0",
         arm64_linux:  "8c17dcda282453e24bfa5216fef499e4b1dc9e20ef3a6da4d59a4aee746e6ba9",
         x86_64_linux: "cc694c5a9e4670bdd1d4fc1b7916f2763de4efbaab8dae6b7391a8ef253f785f"

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
