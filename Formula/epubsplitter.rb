class Epubsplitter < Formula
  desc "Split EPUB files based on the table of contents (toc.ncx)"
  homepage "https://github.com/renchangjiu/EpubSplitter"
  url "https://github.com/renchangjiu/EpubSplitter/releases/download/v1.2.1/splitter-1.2.1.jar"
  sha256 "b0c227784f591febfafc697dda3e10663a218ade27108ba4f0f547bda25486b8"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["splitter-*.jar"].first => "epubsplitter.jar"
    bin.write_jar_script libexec/"epubsplitter.jar", "epubsplitter"
  end

  test do
    assert_match "usage", shell_output("#{bin}/epubsplitter 2>&1")
  end
end
