cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.137"
  sha256 arm:          "29c55f9a3bc591d483b13101135c96f9a383a493602fb5d53a53430e6d911b78",
         x86_64:       "ea9b86e4a93dcbe37d83f42e234940384003bdb7a458c4ab9f475928f7de7d21",
         arm64_linux:  "5b51505f1c77421d6ca75ad05dddbf024af41e25cad87e4343ed7ceb59c1e239",
         x86_64_linux: "6d3b0a2445cd453dbdaf6bbd25d309dd3124f04d8f96b6c15cd98aef2dc0d8b7"

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
