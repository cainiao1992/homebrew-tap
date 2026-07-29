cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.143"
  sha256 arm:          "2f158d46f9b6c5eb0dfe4eb02038114001e17acc47b67347417c56dcf9659096",
         x86_64:       "693d243db616c74705fec9d92fdfc8a3db36acfcea378edb7264c2a30d339d9c",
         arm64_linux:  "c50298e4698fcd1b15fe1a0f096405ad260b5c84d4440882582d0bba1e57bd49",
         x86_64_linux: "6a29c598a789b57c92c03e560907d3f131a4bd0a068785b1d338a86fc31a58a7"

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
