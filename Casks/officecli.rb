cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.158"
  sha256 arm:          "67cf08d95fab556cad9d1e9d0d3b76a7962b5658c716aeaef2e83cbc19af7ff7",
         x86_64:       "038716417adb626d5e94bc71dfecea2d2be9838f3d9b2eb49c2f0b3d634cf4f2",
         arm64_linux:  "b1d5e74d93a8471a47b037cc7774ac29c559940e226f99b9fdf788966cc395b8",
         x86_64_linux: "9ee41d5558caea7bcd5aab1b3e76b2bd70f0535f09cf65dda3668130510cc719"

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
