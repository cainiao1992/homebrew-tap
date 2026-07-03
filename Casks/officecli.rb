cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.127"
  sha256 arm:          "1dbe179e88af3242326550f81a35cc321841a9c743410df5399699a057274e4c",
         x86_64:       "0c55b2eddd26e890a3478ac0cd2da7db93c7a37bdde8a5db6cee863c6ccdca20",
         arm64_linux:  "cec3659fc7c16514b346d0b5be220dd233d0589b78688952ddca1354f4e196fc",
         x86_64_linux: "77a339d25498d0aceb11e1ab149c7edf4b20dad5895ceeedce320b9fd0fe8ca5"

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
