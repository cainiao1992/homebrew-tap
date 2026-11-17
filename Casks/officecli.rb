cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.162"
  sha256 arm:          "7c54c00bfea9d28a69282661f0e3a08d455c8fca1a1d486f4c146c867b693797",
         x86_64:       "770a2b0fcb2dd9e964a10c71a52a159a022138185fdedf990ab587fc5263af9e",
         arm64_linux:  "59763bc3e9f03784fb4ddb7a2571deabaaf5fb999f42aaee6407191424c38816",
         x86_64_linux: "df40e8f21b5c84826565f7c9c96f7e1a70ffbfe141b507bdad70533eaeacc190"

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
