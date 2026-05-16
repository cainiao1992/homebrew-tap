class Officecli < Formula
  desc "AI-friendly CLI for Office documents (.docx, .xlsx, .pptx)"
  homepage "https://github.com/iOfficeAI/OfficeCLI"
  version "1.0.93"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/iOfficeAI/OfficeCLI/releases/download/v#{version}/officecli-mac-arm64"
      sha256 "b4727c707fd101c9f09905dba9e80e801cc065a7fc21ce1868d47429730dff02"
    end
    on_intel do
      url "https://github.com/iOfficeAI/OfficeCLI/releases/download/v#{version}/officecli-mac-x64"
      sha256 "868317964468b066acdd20f3f5ceafba683cdd02c79d8a45000a8108b5eed9c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/iOfficeAI/OfficeCLI/releases/download/v#{version}/officecli-linux-arm64"
      sha256 "f319849b8a9905f9b936700bb1f2d0e9ad099e8abef584206148b0b600710a01"
    end
    on_intel do
      url "https://github.com/iOfficeAI/OfficeCLI/releases/download/v#{version}/officecli-linux-x64"
      sha256 "11ac7f85c9f2f82adc266a97a353c362c87d48a5812a2552b133324dc922d102"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "officecli-mac-arm64" => "officecli"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "officecli-mac-x64" => "officecli"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "officecli-linux-arm64" => "officecli"
    else
      bin.install "officecli-linux-x64" => "officecli"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/officecli --version")
  end
end
