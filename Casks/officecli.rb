cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.132"
  sha256 arm:          "f51c96607ad57719251d67b74dedc1159910b7835fd503dc622b12c02e7af535",
         x86_64:       "d483595270f9e93414c667f266b6394204ff1ea72d0bad15135d09a18dea352c",
         arm64_linux:  "c3245a410234546caf672e60a7b2588504e6dabfbc691bb545ec6ae680622160",
         x86_64_linux: "b96abbbdf1050da090b014d4169656c14cecf14a1892dd2ae7d721be037c8a35"

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
