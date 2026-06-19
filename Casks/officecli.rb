cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.115"
  sha256 arm:          "8a5b11e6097d661a6b05b2343409b0acbb77eae4fafc86c431b83fc3af5bba47",
         x86_64:       "eb1e2f5b1cbbbc6a2a19ff2a90095922d6b45a466b9e3e08bfef7ae0301c0f0d",
         arm64_linux:  "0b0edcc0e590d28fc393f56af168f56b7ebe724fa40d36b98796b723e61206d1",
         x86_64_linux: "82c0fd95506f535899d60dc7e1ac1cefe55a5b4f409781303d18d4f3a9cfad79"

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
