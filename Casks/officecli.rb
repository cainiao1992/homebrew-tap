cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.112"
  sha256 arm:          "df1e9c3adb082b880ad16a8c22e857bc72453abcb7862b035062998cbcd3cd38",
         x86_64:       "1f5e6d28a02d82cb5798a4806747026f2e498a48a6d3f4a21c61c05523a43a1b",
         arm64_linux:  "89aa76e2adda52029dc1e1763f5cc182deff65f974cd065ec1cd98da33d8150b",
         x86_64_linux: "bdde42a154fa3be96ef991fedb06128afe39ac9491dbd3f76985f43e7f9c5610"

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
