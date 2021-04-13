class Cling < Formula
  desc "Build with sutoiku patches"
  homepage "https://github.com/sutoiku/cling"
  url "https://raw.githubusercontent.com/root-mirror/root/master/interpreter/cling/tools/packaging/cpt.py"
  version "0.3.11"
  sha256 "ea68176e3636a816e89ad14bd348061c7e47c3f1b0c4112c8f3a73b28162ad4e"

  bottle do
    root_url "http://homebrew.stoic.com"
    sha256 cellar: :any, mojave: "2c3b35775f1c5d43e8159feb85588a1d6963258e5609a99ec833ea0fd13378a8"
  end

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    chmod "+x", "cpt.py"
    system "./cpt.py", "--current-dev=tar",
             "--with-clang-url=http://root.cern.ch/git/clang.git",
             "--with-llvm-url=http://root.cern.ch/git/llvm.git",
             "--with-cling-url=https://github.com/sutoiku/cling.git",
             "--no-test",
             "--skip-cleanup",
             "--with-cmake-flags=-DLLVM_ENABLE_EH=ON",
             "-DLLVM_ENABLE_RTTI=ON",
             "-DLLVM_ENABLE_THREADS=OFF",
             "-DLLVM_OPTIMIZED_TABLEGEN=ON",
             "--with-workdir=#{buildpath}"

    system "make", "-j16", "--directory", "#{buildpath}/builddir/", "install"

    mkdir_p include.to_s
    mkdir_p lib.to_s
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/include/* #{include}/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/cling-src/tools/cling/include/* #{include}/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/cling-src/include/* #{include}/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/lib/clang #{lib}/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/lib/libcling.dylib #{lib}/"
  end
end
