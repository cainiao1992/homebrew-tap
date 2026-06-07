cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.104"
  sha256 arm:          "d1d4fd2bb0074437779450d54bb09ae611c9fd8cf64050008b0cac3bac177a91",
         x86_64:       "ca96c9f14e997a19e2cff2fc6c4a532b6cc6faa6c088293be4da60a3b50f7847",
         arm64_linux:  "5d938f7073a59befe36b0f076b0c2b813988e9f71f713408b95cff390dff216f",
         x86_64_linux: "8aecd980891940c968833fbe34ef0fa765da7d25643ead3818542029af81643f"

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
