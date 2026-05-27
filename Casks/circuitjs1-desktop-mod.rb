cask "circuitjs1-desktop-mod" do
  version "1.3.2"
  name "CircuitJS1 Desktop Mod"
  desc "Offline Circuit Simulator based on modified NW.js"
  homepage "https://github.com/SEVA77/circuitjs1"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    arch arm: "arm64", intel: "x64"

    sha256 arm:   "3d9b42f775a4d5f587a108bfa02aa71241ac6e6b46169f32253203821a17ce6c",
           intel: "1abd64ce2221c914adfdf28e34c71c77a8b0ffbb40cbb0b264ef94c486cd6240"
    url "https://github.com/SEVA77/circuitjs1/releases/download/#{version}/mac-#{arch}.zip"

    app "CircuitJS1 Desktop Mod/CircuitSimulator.app"
  end

  on_linux do
    sha256 "19ee0215c236a6c2c69fe26a31ec4d588ff9e5e7ae124d7c004787c00fa277e8"
    url "https://github.com/SEVA77/circuitjs1/releases/download/#{version}/linux-x64.tar.xz"

    depends_on arch: :x86_64

    binary "CircuitJS1 Desktop Mod/CircuitSimulator", target: "circuitjs1-desktop-mod"
  end
end
