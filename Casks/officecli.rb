cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.131"
  sha256 arm:          "1a10e73e73e1a3aa278d75af8e966ce932691bbf9958a06578638c42181894fb",
         x86_64:       "daa90b846c85a2ca61eec743fd41da6d02f74c7c68560ccecfdab2e977737730",
         arm64_linux:  "db73a88be9215db9a857d3148fce1f401d78dc8e99428ad209c6444264e7ca17",
         x86_64_linux: "e027f650495057dc241d6bedab1fc40b6e385ffc1ab930c3ec433e738e785bfb"

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
