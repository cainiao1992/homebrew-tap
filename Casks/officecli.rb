cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.150"
  sha256 arm:          "e669fe5a4a162f8f0f8dc871d8d85e2a15d191ec93f94426a1ecccf9d57978c8",
         x86_64:       "3af47fd4ea86a31f228f71cf8b2a97f609784031a049aaed4ba6170606d3d0ed",
         arm64_linux:  "93bea35aaa8f153a56a4f6e1a7d22d82aec379e42ce2d45b24b0941dcfd50968",
         x86_64_linux: "faceb42654004f1fa5c40fb0ce641c42b7dc5a2beb270f25971ea6265b7dc227"

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
