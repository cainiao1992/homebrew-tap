cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.123"
  sha256 arm:          "8f83e80767d1deca2dd8fdca1285cb6b43e614f474be3fc9bdab3d4da2186389",
         x86_64:       "054f0212dbd027758ed476d81d59dfe44c0d956a169f2257bc44aa059bdfb035",
         arm64_linux:  "c9cb5a17b9c12cb99e564a1d9f73f92ea0dac752190ec5e9c5115cc139f278b0",
         x86_64_linux: "fe2434ef19a9a2a9584d174ef23058f1b79d8f9f7bd548ce58e85acbc4ff52e3"

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
