cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.145"
  sha256 arm:          "d66763a563bc844c3cc67036ebc7c4a9caa9319b9592814d9acd3706da231fc1",
         x86_64:       "d7dc7013f7bf0af6345ae16a7913e6cf041947460d7f2fa3e024f0b27073d0a2",
         arm64_linux:  "d38233bb7df4f0f5fb40313de1f00c0f0e575dc96b4164742709711ceec148c5",
         x86_64_linux: "449f0e6a1298e3c6d7da792d26ab53d04ba77bd990f299b51123c7aef383d2ce"

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
