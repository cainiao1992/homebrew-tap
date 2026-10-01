cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.153"
  sha256 arm:          "61d6449da326c234149352a82e6047bd73b38e7d34d8b23310bd877b4ea65e79",
         x86_64:       "64d5084ed2fc7cce05954ecaf5f8247d53fa272626d5872f6fb1f018bc628fee",
         arm64_linux:  "29c2527491331ac7b1ad6ebb4aa5ff9a666f06353675463aae9a832237ef0fda",
         x86_64_linux: "dc1bf7ec9e0bf3ac45c5bd32934842ca2f8939775660526e057642ea68606a80"

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
