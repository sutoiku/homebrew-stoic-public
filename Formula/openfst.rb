class Openfst < Formula
  desc "Open-source library for working with weighted finite-state transducers."
  homepage "http://www.openfst.org/"
  url "http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.9.tar.gz"
  sha256 "de5959c0c7decd920068aa4f9405769842b955719d857fd5d858fcacf0998bda"

  bottle do
    root_url "http://homebrew.stoic.com"
    cellar :any
    sha256 "b7bf2151e68110dc4e38ecee5c50a85295cd5395d9e0dc7cf27d56a584f6832a" => :high_sierra
  end

  depends_on "zlib" unless OS.mac?

  def install
    ENV.cxx11
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--enable-compact-fsts",
                          "--enable-compress",
                          "--enable-const-fsts",
                          "--enable-far",
                          "--enable-linear-fsts",
                          "--enable-lookahead-fsts",
                          "--enable-mpdt",
                          "--enable-ngram-fsts",
                          "--enable-pdt",
                          "--enable-special"
    system "make", "install"
  end

  test do
    # Based on http://openfst.org/twiki/bin/view/FST/FstExamples.
    # Makes symbol table.
    File.open("ascii.syms", "w") do |sink|
      sink.puts "<epsilon>\t0"
      sink.puts "<space>\t32"
      33.upto(126) { |i| sink.puts "#{i.chr}\t#{i}" }
    end
    # Makes arclist for downcasing FST.
    File.open("downcase.arc", "w") do |sink|
      sink.puts "0\t0\t<epsilon>\t<epsilon>"
      sink.puts "0\t0\t<space>\t<space>"
      33.upto(126) { |i| sink.puts "0\t0\t#{i.chr}\t#{i.chr.downcase}" }
      sink.puts "0"
    end
    ## Compile the machine
    system bin/"fstcompile", "--isymbols=ascii.syms",
                             "--osymbols=ascii.syms",
                             "downcase.arc",
                             "downcase.fst"
  end
end
