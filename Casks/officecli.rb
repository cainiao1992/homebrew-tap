cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.138"
  sha256 arm:          "761d9c2a6778d3932883bce7b8741284ad22f05f737a444b1e05b21c368f780a",
         x86_64:       "a4a18e16c757576a343f18963bb1494a8dc490794d7e6c9bc379f906915a8e8b",
         arm64_linux:  "2c43eec01356cf29f67e7ac0ca4ac51ccd8b4cf49e2a184b0201f1556403c601",
         x86_64_linux: "c784d89fdadfa3c6adc70b6f74bff7a6a04f7cc2b105a764369e266cca885b2b"

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
