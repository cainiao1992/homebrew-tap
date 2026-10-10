cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.156"
  sha256 arm:          "8a6c1aa383ee8b9069d012914418a4814d183727ca100b6c3d1ef2839a460290",
         x86_64:       "9487262651e76bf6f586a5edaa41c01b7318991aa10c382d0d46065259fac3bd",
         arm64_linux:  "972198c8db1f992ffd3fec4ecf6694533ecbdbae8da7a021ab513e73ecb2f15c",
         x86_64_linux: "a5ed6e4157fe9b24a099cd24ff30e89a4349b7a7d782d2b7de8d56294c7e1423"

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
