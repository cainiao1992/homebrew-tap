cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.117"
  sha256 arm:          "a53a4dc1e0aa9ebfc2025b40e3cfb1dcb6f52b57fd6d8e3bedd858c16bbded17",
         x86_64:       "f20ce0ae9224605c6518481e1b46130378d918ca270d69e40cbaafc704c10108",
         arm64_linux:  "7e738f93d233b0680e95c8e31b036c6acf4a561ec3e4a1ab25404704b8fad793",
         x86_64_linux: "58e69a0f45bbcbfe1196ca43d0b71cf301946b3dc369076fb931b36b4c0931a3"

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
