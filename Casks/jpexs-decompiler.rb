cask "jpexs-decompiler" do
  version "26.4.0"
  sha256 "fd099f302bd99f4c219ced805c9fcfb665459c09a4dd9755c987f56536bb265f"

  url "https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version#{version}/ffdec_#{version}_macosx.zip"
  name "JPEXS Free Flash Decompiler"
  desc "Open-source Flash SWF decompiler and editor"
  homepage "https://github.com/jindrapetrik/jpexs-decompiler"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  app "FFDec.app"
end
