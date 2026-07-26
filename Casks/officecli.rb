cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.142"
  sha256 arm:          "684ce214bb8d750003d521eea044a9199bcbdb870817dba5d3191b35715ea38c",
         x86_64:       "d2d27d8203ec8fc178a6a55eb4ce0ca63696e4ceddb7f85eab359da77f343a91",
         arm64_linux:  "260cdccd27f2e25902e9436e5e971c0ca5348ae3d36a54a3fbd794c452ba13f7",
         x86_64_linux: "f78563abc13cf70dcd420644019d2f11dc36ea2957ac738613a6911d652b5541"

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
