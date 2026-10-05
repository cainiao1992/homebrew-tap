cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.154"
  sha256 arm:          "a05c82e04bd0f283ea309f20e4092d540632438cba8ecbf192e65209f780c372",
         x86_64:       "d7a63396a76f436c6bc993092c999ee1d37f985eacce2b09a3a3eba37c9baa4f",
         arm64_linux:  "7e8d23026e678fb5222e55e88a5e4b80226738cb83592ae2268b8a17e480a765",
         x86_64_linux: "ac57d4d94209c21e34fc133eea2b55670e5f966a9e8e6b68f656b9410db5dbae"

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
