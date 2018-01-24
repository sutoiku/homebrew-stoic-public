class OpengrmThrax < Formula
  homepage "http://www.openfst.org/twiki/bin/view/GRM/Thrax"
  url "http://www.openfst.org/twiki/pub/GRM/ThraxDownload/thrax-1.2.3.tar.gz"
  sha256 "66491182584eed31a323324e8478042c8752c112d13ef7c4c66540b4f9df431d"

  revision 2

  bottle do
    root_url "http://homebrew.stoic.com"
    cellar :any
    sha256 "55cca5e4b35fa90740e6dbf3279657629b307ea5ffccfaf04614bf2953a00519" => :high_sierra
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
