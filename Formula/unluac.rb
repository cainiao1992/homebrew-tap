class Unluac < Formula
  desc "Decompiler for Lua 5.0 through 5.4"
  homepage "https://sourceforge.net/projects/unluac/"
  url "https://downloads.sourceforge.net/project/unluac/Unstable/unluac_2025_12_23.jar"
  sha256 "98be0fa84ac73ca66dce2842a2e4512226f4c611b6500dc96415571fc5538fcc"
  license "MIT"

  livecheck do
    url "https://sourceforge.net/projects/unluac/rss?path=/Unstable"
    regex(/unluac[._-](\d+(?:[._]\d+)+)\.jar/i)
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["unluac_*.jar"].first => "unluac.jar"
    bin.write_jar_script libexec/"unluac.jar", "unluac"
  end

  test do
    assert_match(/usage/i, shell_output("#{bin}/unluac 2>&1", 1))
  end
end
