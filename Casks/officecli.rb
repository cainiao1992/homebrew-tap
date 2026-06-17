cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.114"
  sha256 arm:          "e6763b8c60d04d43c0bc996d6e66e198164ea09be0884dd21847c71d293d054c",
         x86_64:       "9991cec5a1b36ff15174c80d6b8eecab35c431910050a3a8ff295a7cf43c5ca0",
         arm64_linux:  "2af6de6221fbb390835c20a262946d493ef5b5c46f32ca9d18b0417633b1e2f6",
         x86_64_linux: "3d43335fb58bbbfc4a6b4cb4e50c53b7fb27066c8008ed331790f37683a0d3a7"

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
