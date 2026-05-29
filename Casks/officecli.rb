cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.102"
  sha256 arm:          "964b23466549681f5283c922cc535d8914d8d089d453bb5d0a100cec6c5fe206",
         x86_64:       "99be36950b43782cc0e02ba6be4afe5db3d6b4788f0fb32853f4d3ead5950b78",
         arm64_linux:  "dedca5682cad211df9c75886936b441475cf7840a8bd6974dcbd2278c7f1d1a1",
         x86_64_linux: "d58438a2d701ec68685bb04bb043b546696b1620f141e670eaf438dae5898a66"

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
