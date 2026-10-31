cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.160"
  sha256 arm:          "fe2b31c6c27534dfbbf155386b6b9105420f9315bbb606335ec61490d171386d",
         x86_64:       "55b27f6d422f9e0bcd2aa40abb262606110ff957a4a5253db7a8ba0460cd81c7",
         arm64_linux:  "e8f06aff6c59f11a73a1a1218bda3ce170299201fd56bce6d62ecd4d0c024e53",
         x86_64_linux: "baa084b64ec634bd9d41a0592db3ed85f11658b358bab898679537ea7f3e73a9"

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
