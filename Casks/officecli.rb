cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.126"
  sha256 arm:          "e2421354a739292f658823fd4046165d70a86635ec22cf7998e233298187f182",
         x86_64:       "aeefd0fa0fd6a8c1cce8e6cd8c6074702d9217d2ccfbc97e1cffe2ef58006a88",
         arm64_linux:  "449a36883f9f8c0b530c3581dce004f0e4956312b33370b1a73a1680fb55b764",
         x86_64_linux: "6b77730f016818dc84efa08ac60f89f2c948cc3ed24ca86ccfc6d13fef1e74e5"

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
