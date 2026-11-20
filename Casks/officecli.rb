cask "officecli" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"

  version "1.0.163"
  sha256 arm:          "12bbe7c322a4114533bcc115e8ff6255917a35de0432c85111be534c82a9cbe1",
         x86_64:       "d9737acd91771bcdbc33850423a7edc4a805cc8dd4053a910cd88401baba630c",
         arm64_linux:  "94dd4e1e5db095d2eec691a74c6fd508bf4b651432aade07d41a217cf997ff83",
         x86_64_linux: "ba4d75d293aefee222659793074d569a3f94a34a28e2894bfe6d018015cffa95"

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
