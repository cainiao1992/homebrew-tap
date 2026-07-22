cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.140"
  sha256 arm:          "d83d68a6138c9a8456707db86f9ff62813a2d752d08ea725b3c8f077950086ba",
         x86_64:       "61b864e628d0cf4e203b2b8e679bccdaf657e0328d54f17d08173181a2adba13",
         arm64_linux:  "924dd58f57891d1b3fe8cf77f06990f58f8f0c0ddf6fe22e1d91c7f10d3e7576",
         x86_64_linux: "cee68cc2108074e5ae5ad114e1cd5cab4514da8ead4983d5d94aa0acba4f41e8"

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
