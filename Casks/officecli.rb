cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.129"
  sha256 arm:          "25945dbd026004a0e2c2a8076fe7ee4a09d8a4ad9b97c023e0a5bdc9fd6abd91",
         x86_64:       "96d4bfdad37462caaf54c4bcdc620e36235aa306b6d2874fa140edbec94e6b8d",
         arm64_linux:  "a2d99407e883e4f172e6ace9509d8406b73f31d4f944d702ee8b6d20331e6b65",
         x86_64_linux: "1e44357f86b4c664b2e49d18b3b8e2d17947fa4d45b47a1d725a58c65db34159"

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
