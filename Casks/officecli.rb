cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.146"
  sha256 arm:          "fdad1c51a95d18c4851f54327b7eec9f766b12a984e0930b48d877d5559e3161",
         x86_64:       "2b5547588a69270f649fbe623c4541755510f7501717f830e656a5408062198f",
         arm64_linux:  "b3204a1a8a7949e44638267722f2abb6135be89f83f138fb6bea586c0e57af30",
         x86_64_linux: "bd343d96018a9ec4a72ff3599877a4fc4fed233258a62eddc06169711170d843"

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
