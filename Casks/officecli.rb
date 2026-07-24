cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.141"
  sha256 arm:          "a9639df060513d73b125849e4c630383f7a80f70e61911ef486dd24ec2208e37",
         x86_64:       "4a46518c19b42dc28bc7dfad74101e666ee81cf0c11a9843979e2d39ce0c68e6",
         arm64_linux:  "0aa4f01ec47de12f2bead5b98835d329179ba0cf7de9a9dd27bdd59aadfde9bf",
         x86_64_linux: "4a542155ce3e1b0c211ba117d5d3bc6c25357d74fd5ba55786f1c29c12ac866e"

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
