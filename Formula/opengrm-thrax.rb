class OpengrmThrax < Formula
  homepage "http://www.openfst.org/twiki/bin/view/GRM/Thrax"
  url "http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.7.tar.gz"
  sha256 "2fbc720fb518cc611553e9375099067166b918d8980872b943f49763f4514c00"

  revision 2

  bottle do
    root_url "http://homebrew.stoic.com"
    cellar :any
    sha256 "841d8a31ac8fab49b194493b8a0a7df4b130b5e315667fa15084318b0709ab27" => :high_sierra
  end

  depends_on "openfst"

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
