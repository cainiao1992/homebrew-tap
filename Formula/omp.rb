class Omp < Formula
  desc "Coding agent with the IDE wired in"
  homepage "https://omp.sh"
  version "19.2.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-arm64",
          using: :nounzip
      sha256 "43943119837612b2da72250ab7efe22ff8ca239eabebd4f702f34e3a144fdd3d" # omp-darwin-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-darwin-x64",
          using: :nounzip
      sha256 "4face26750f5679857a606a61df22b1587925d4b308d5938de470d8c780cd871" # omp-darwin-x64
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-arm64",
          using: :nounzip
      sha256 "92d4cce4b14814f6b838aa86dcec6359f0cb089cbcc300e8463cbb5326991fe0" # omp-linux-arm64
    end
    on_intel do
      url "https://github.com/can1357/oh-my-pi/releases/download/v#{version}/omp-linux-x64",
          using: :nounzip
      sha256 "e8b937f9bf023baa147bdd300ad5421af0a6ef8b1f350c47a9a93d5fca94feca" # omp-linux-x64
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
