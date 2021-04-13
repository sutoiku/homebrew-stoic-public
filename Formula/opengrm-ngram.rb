class OpengrmNgram < Formula
  desc "Library for constructing ngram language models, represented as weighted FST"
  homepage "http://www.openfst.org/twiki/bin/view/GRM/NGramLibrary"
  url "http://www.openfst.org/twiki/pub/GRM/NGramDownload/opengrm-ngram-1.3.4.tar.gz"
  sha256 "3101950b937d058ea4479cfe046aa023acef92fa96d1d8302238a8da5f66ea4d"

  revision 2

  bottle do
    root_url "http://homebrew.stoic.com"
    sha256 cellar: :any, high_sierra: "58298116468472a1ece7a7a3c5d3b65ceac22147acb015c59d82903979607af4"
  end

  depends_on "openfst"

  resource "earnest" do
    url "http://www.openfst.org/twiki/pub/GRM/NGramQuickTour/earnest.txt"
    sha256 "bbdde0b9b7c2150772babbcf8b16837eb7cb40a488b7390413b342009c03887f"
  end

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    resource("earnest").stage do
      fname = "earnest.txt"
      # tests using normalized The Importance of Being Earnest, based on
      # examples from the OpenGRM "NGram quick tour" page...
      system bin/"ngramsymbols", fname, "e.syms"

      # NB: farcompilestrings is distributed as part of OpenFST
      system "farcompilestrings", "-symbols=e.syms",
                                      "-keep_symbols=1",
                                      fname, "e.far"
      system bin/"ngramcount", "-order=5", "e.far", "e.cnts"
      system bin/"ngrammake", "e.cnts", "e.mod"
      system bin/"ngramshrink", "-method=relative_entropy", "e.mod", "e.pru"
      system bin/"ngramprint", "--ARPA", "e.mod"
      system bin/"ngraminfo", "e.mod"
    end
  end
end
