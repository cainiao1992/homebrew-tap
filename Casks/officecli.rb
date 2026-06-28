cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.125"
  sha256 arm:          "1ab0159a986b0c77e7b164740f0d88fae172b4268fe78c1b9e4790b02ac4725d",
         x86_64:       "2e50c5a6515e6f5f111324efb979a794cefdfc489ab1f9389b2ea69739290ed0",
         arm64_linux:  "9d5020214e4986f95053051a5fced6e28564939e5c859fa7260a32bfa0fd81bb",
         x86_64_linux: "560ecc22d50d506937663509025bf1ad71c81e62e3d2f1086b45d961e91ff52f"

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
