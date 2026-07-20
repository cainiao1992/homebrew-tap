cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.139"
  sha256 arm:          "393874f79db58222bdbede7f4f942f2536580386923857d1b5ad9754efe80c19",
         x86_64:       "6a931d424975dded6ae413c8c1f63d00dfb30a4bd4bd50352964782d13299f5c",
         arm64_linux:  "39008c7f76d202858637810553ef14e2cd3e7f61485fdcf2011f26967a7babd1",
         x86_64_linux: "da07d4f787d7c85724104294ac023c89971ddfaee93ebb183b289282b8f869cc"

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
