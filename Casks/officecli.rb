cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.135"
  sha256 arm:          "0d2a32c7dd460e275ddd8c442be33a8221a32021d4d5f7957cd44a70b2d927dd",
         x86_64:       "77178c638ba5b12d21896f9b0091081079645089bc1d909e3b3097e1649bda5c",
         arm64_linux:  "2ec0d5a455646647f798f723e62fd9c18e2e801f8460d4401d2554a6a1c6d5b0",
         x86_64_linux: "00028af3db48678fc9ff6c8f9e70fa4c150dcee2b43ed85254afc8f4a48e13eb"

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
