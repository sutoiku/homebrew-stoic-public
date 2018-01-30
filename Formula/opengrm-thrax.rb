class OpengrmThrax < Formula
  homepage "http://www.openfst.org/twiki/bin/view/GRM/Thrax"
  url "http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.4.tar.gz"
  sha256 "c532cf95ea209625b1a49677ac8596131e1a473817ac946cf24788105eb24986"

  revision 2

  bottle do
    root_url "http://homebrew.stoic.com"
    cellar :any
    sha256 "841d8a31ac8fab49b194493b8a0a7df4b130b5e315667fa15084318b0709ab27" => :high_sierra
  end

  depends_on "openfst"

  needs :cxx11

  def install
    ENV.cxx11
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    # see http://www.openfst.org/twiki/bin/view/GRM/ThraxQuickTour
    cp_r share/"thrax/grammars", testpath
    cd "grammars" do
      system "#{bin}/thraxmakedep", "example.grm"
      system "make"
      system "#{bin}/thraxrandom-generator", "--far=example.far",
                                      "--rule=TOKENIZER"
    end
  end
end
