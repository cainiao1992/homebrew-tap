cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.113"
  sha256 arm:          "35a733b598cb32a57d4edc1217a5edfcf63aa9c141916b0b4ef54aa37e4c30ba",
         x86_64:       "62ad1b63ec1b833efe01a51d3564238ce274b51a785b1a2fc91880c66381b0d2",
         arm64_linux:  "893874471e6830d29580ba9cab0a5834eab80278092f77edb31292bffff1f9fd",
         x86_64_linux: "ffe09f5f8ec76240e44ff431b802b8a4466775afda328f1f7b606e3a79807311"

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
