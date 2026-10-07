cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.155"
  sha256 arm:          "6b83cac55120995019f299b632d9a7c9e89268f382b726e1dad123864e3b57aa",
         x86_64:       "c3eb7b127af72f1de5e870c7f9b72443da0a0d2f182bdf45c9361fea3f8fedb7",
         arm64_linux:  "1af89db83dc5e82ac22f1b9719b377d0edcb8128eb04e795e85ae0a1ac2dcc69",
         x86_64_linux: "1a5da5cb7e9d995db7a6560beb7466760c79617648f72e65f4ce55897c407f67"

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
