cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.148"
  sha256 arm:          "501a67fe52ad2afc5cc5626287a204082083db431e5532dd361d6b55158caed1",
         x86_64:       "235055a83a33e9e675bd85de7a03c9ee657a81d57aad6a24fa41b954caede1b6",
         arm64_linux:  "edddf5610b97113bb3c0dc99fac16aade3d3f34746c054ab6fe828679ec48438",
         x86_64_linux: "e424210bce9355f498eeaf692b4d2b13f1f3422e1db34636c41f54c36025249b"

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
