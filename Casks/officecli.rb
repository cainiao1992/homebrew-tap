cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.100"
  sha256 arm:          "e33ada27a90a31cfc96a744930eafa4f54e159defd1f7de0b5fbffa5dd6a10f7",
         x86_64:       "a9f10ab76fa9795baeccb4e88276e98426d3fba8dfe3eb9fcd0351c2b8496859",
         arm64_linux:  "c2d9a1a5b7382092ede47b32326a00cdbdd74b20652ad3e009869c65ad1d192f",
         x86_64_linux: "9a54345c97f0891dee90d573d9f3fb7179b5f5343ca3738ad11eda99c5dd7bf5"

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
