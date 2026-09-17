cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.151"
  sha256 arm:          "ff6834c0b4aa8a37ed78232373ed8f3acb656e1bbac4cb61ee475681cb32bec6",
         x86_64:       "f24b200675ff88ce289e079bdaa34a16fabe425444c7b6d906541dae26745792",
         arm64_linux:  "fccb7d7841c9ec93593a62181544c893ee184455421cf15bd76110bf0ad29c41",
         x86_64_linux: "8e2512234ae1111e51ad3a9fadbdeca266adfa7f683773469aa45b83fe06dc7f"

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
