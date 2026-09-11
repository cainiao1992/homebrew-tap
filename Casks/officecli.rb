cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.149"
  sha256 arm:          "f35c3243cd8832394bfe6c37ae02648898d794d703ddb4d6d08903ea52038684",
         x86_64:       "5f961cbab95b959774a9d67c8931545f18cbad906ed7f45c09f36e2e2e3d310f",
         arm64_linux:  "5de8e6e6b0d5068573fcce84cfafa795fa2186907fc452ddfb6dd493ae4f6c3b",
         x86_64_linux: "ba0f397351ca3c31109ddc8e9690b848304da77594fd7573a76f2b1eb7e430e7"

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
