cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.147"
  sha256 arm:          "55569d8a7430c1d8d7872c1661ff8cfea2eeef03ffc4fa8dbee437a4c91ee1ed",
         x86_64:       "9f957b9439b922916360189bedfb780defc471b95ab8670f2a5a9630e7c9c253",
         arm64_linux:  "f90c734722fd2f41ae76e72878329f033ed36c132aa741ec44dc3827066c55b9",
         x86_64_linux: "e8bfe04f670139f526fe4e81f11acc1bc8629e421a20c5ba7a6e25f7a54a31f7"

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
