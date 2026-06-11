cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.110"
  sha256 arm:          "1f39fa570427f0fe070c4f55f74e199dd95af88276175b3ae4bccdc9afb38ee7",
         x86_64:       "4b4f1e6f10971d4541c97cd6e618e1907ee6f5a50b96066b451b2a67d9442522",
         arm64_linux:  "a3a6c5f775146774c8a0ac8e302b9b8735c9c68bf057b864bbc51e747295447e",
         x86_64_linux: "95e05634817197952c72d74fddf322e0d0779647f0f7a49e6de30835f9d626e6"

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
