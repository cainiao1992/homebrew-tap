cask "jpexs-decompiler" do
  version "26.3.0"
  sha256 "79a38e785825a3b90dd291537110f01fbec135637966f5552eec5344b5e97410"

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
