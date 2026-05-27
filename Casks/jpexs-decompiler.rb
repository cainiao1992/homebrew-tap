cask "jpexs-decompiler" do
  version "26.2.1"
  sha256 "a160249e037115b935db253e993a6c00694f5d89bc4808c379e9a08a4034795c"

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
