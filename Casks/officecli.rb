cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.116"
  sha256 arm:          "e57f19714596a9ed5375d5abb49d0e51380fd0b543ba773253987a8ca23a35b9",
         x86_64:       "82cf38ae10dcd429358fa9f097794eea7b38646d104930d7ddfc9af499be2ac5",
         arm64_linux:  "71e8ac723a9c2302131d668116c0d4b0900e8fbe106773cbd35ba9d5a1b406a8",
         x86_64_linux: "56bc199cec703a2ef52161db1ceabe3f856213e3c95583ab84bfae19cbe03181"

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
