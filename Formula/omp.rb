class Omp < Formula
  desc "Coding agent with the IDE wired in"
  homepage "https://omp.sh"
  version "18.18.6"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-arm64",
          using: :nounzip
      sha256 "ed2e63eb43888eb76cb1409b245b1db4557c94dfad52dc545c9aaca01ebce82d" # omp-darwin-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-x64",
          using: :nounzip
      sha256 "836fea57b1dfcf53c26053aef3d57b6d1f83ec034a7f8b25d789022c5adbc365" # omp-darwin-x64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-arm64",
          using: :nounzip
      sha256 "aa9d69380f7ded098bcd3d8023a67edcc8fc3cc0529360a98dededc21cfa101b" # omp-linux-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-x64",
          using: :nounzip
      sha256 "a8059b95de5eaba0b3fb6f7182842d661feae29cb2931cdbeba2986db4751ecb" # omp-linux-x64
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
