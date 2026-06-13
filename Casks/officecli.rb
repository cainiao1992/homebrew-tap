cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.111"
  sha256 arm:          "7db39c0ff7944dc598b2c6aa12b7dab60e148b4290d442a26e6c605b63aea5d0",
         x86_64:       "6c556c9891b396eebe0a3c7daf18e8085a9dc78e31f88bb20c235edbad98ece9",
         arm64_linux:  "9428e7fcef336ac83d34c463363392bfe184b319ba7b295827de08bea08f9e72",
         x86_64_linux: "010110291f035b09ae462bf40ddfe38b690f3d1abc1d950634793ad7cdc1ada9"

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
