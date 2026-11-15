cask "jpexs-decompiler" do
  version "26.5.0"
  sha256 "1fe2c9373951cf692af947e82d68f076f423391e2b781b667940452103f37956"

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
