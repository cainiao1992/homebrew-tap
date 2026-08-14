cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.144"
  sha256 arm:          "04757163428c5bde8d91e8f838517818e74722157722ca5f3877b6716b77bd45",
         x86_64:       "366100643d757b0da24829422897ca74768a894b5ecd1a471a1336f8e2a0787d",
         arm64_linux:  "56ec2c3114b66f6490888b6778cbb8413a65911a26cacc7207f29e13424966da",
         x86_64_linux: "32ef7a21a54a4ca6c9806bf5e9f3d32bfb1291017329c55044cb2aac71822eb8"

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
