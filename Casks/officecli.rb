cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.159"
  sha256 arm:          "b78ac7f9213e5fd0de0e3cb5d0f81bd427f9dd74b6c31e134fd1167427559167",
         x86_64:       "cc939ccac6fa468e0cd3cdbfdab39efdbf49d88ba9f0efad138fdddf494b1e22",
         arm64_linux:  "a27778548f2820771f54a70887af3c3ec214fe60e63b32836b09b3f3e2c4c493",
         x86_64_linux: "92d9aeed324d91ed2a107f7f8dc7468829b14390a66cf2bbdfb25c40beac50ea"

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
