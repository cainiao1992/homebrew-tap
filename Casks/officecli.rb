cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.161"
  sha256 arm:          "14c71ed62b04e895b0dc4818908ccdc14f6012513350be4ee19c0cbef91fc71b",
         x86_64:       "fc6497a9a1c36cd54d6a239d7aa102491b5b6c6e69535d414cf3a5a3a54505fc",
         arm64_linux:  "3ff44a8f527e4805c0db7abfea8da68b2353f8b1d83e1099d7cae27fc140f95a",
         x86_64_linux: "ed551216f7a62c562d8d231c0416374566684fcc6163176f2ba4ad721c62900a"

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
