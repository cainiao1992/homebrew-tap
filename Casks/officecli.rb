cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.157"
  sha256 arm:          "0dae0990a9cc29688a5d54469f984c34e5b15ab6bbd194a0ffdc571bb9040124",
         x86_64:       "178c1e9ebaf44c24d2b4b359064a5dea6eb7b2f539809871a3de1c09599dff9f",
         arm64_linux:  "60db926c8a1371984b9e99622a834777befb02b6f73d0f3fff914ffcc2760d2f",
         x86_64_linux: "f8eefe88dbfa7464bee421e5421efe57fc26bc3180b30e56eef58594c8245c94"

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
