cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.136"
  sha256 arm:          "b8582853cc464fa0bdb2fabc2803821472c9449c38b365a7be79fcb53d6356e7",
         x86_64:       "f0073b16a5181837d0b0df3e264a338066b02f4ac16f4758538873fbc32bf9b2",
         arm64_linux:  "25bda0d225932159b14ea6ade532c8dbecd2136f1b5c672c003b45bd75afbbb2",
         x86_64_linux: "2ca3d81be529fd103a7af95a2039b051a08af9d1b5c2c96e85e88731008c402c"

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
