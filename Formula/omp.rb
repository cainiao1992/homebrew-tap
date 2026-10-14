class Omp < Formula
  desc "Coding agent with the IDE wired in"
  homepage "https://omp.sh"
  version "18.10.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-arm64",
          using: :nounzip
      sha256 "7459333760ef0e265d5d40445ea459da3d18a10ef3ec4958302e1977b52c8a2b" # omp-darwin-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-x64",
          using: :nounzip
      sha256 "ba70472c9e43d4ca7536a76d03bbe75afadfc1e296ec422161b22e813d5c1062" # omp-darwin-x64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-arm64",
          using: :nounzip
      sha256 "58d711d56fa0c95d208c150575dfdb08fe8fc1262e3820d2d900f0a5e750110b" # omp-linux-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-x64",
          using: :nounzip
      sha256 "ff59fc1b484c1308a7247ad208305005627b3fac62b440737c2b1835ac32074e" # omp-linux-x64
    end
  end

  def install
    bin.install Dir["omp-*"].first => "omp"
    (bin/"omp").chmod 0555
    with_env(HOME: buildpath) do
      generate_completions_from_executable(bin/"omp", "completions")
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/omp --version")
  end
end
