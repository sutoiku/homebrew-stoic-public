# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Cling < Formula
  desc "cling build with sutoiku patches"
  homepage "https://github.com/sutoiku/cling"
  version "0.3.11"
  url "https://raw.githubusercontent.com/root-mirror/root/master/interpreter/cling/tools/packaging/cpt.py"
  sha256 "ea68176e3636a816e89ad14bd348061c7e47c3f1b0c4112c8f3a73b28162ad4e"

  bottle do
    root_url "http://homebrew.stoic.com"
    cellar :any
    sha256 "2c3b35775f1c5d43e8159feb85588a1d6963258e5609a99ec833ea0fd13378a8" => :mojave
  end

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    system "chmod", "+x", "cpt.py"
    system "./cpt.py", "--current-dev=tar",
             "--with-clang-url=http://root.cern.ch/git/clang.git",
             "--with-llvm-url=http://root.cern.ch/git/llvm.git",
             "--with-cling-url=https://github.com/sutoiku/cling.git",
             "--no-test",
             "--skip-cleanup",
             "--with-cmake-flags=-DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_THREADS=OFF -DLLVM_OPTIMIZED_TABLEGEN=ON",
             "--with-workdir=#{buildpath}"

    system "make", "-j16", "--directory", "#{buildpath}/builddir/", "install"

    system "mkdir", "-p", "#{prefix}/include"
    system "mkdir", "-p", "#{prefix}/lib"
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/include/* #{prefix}/include/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/cling-src/tools/cling/include/* #{prefix}/include/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/cling-src/include/* #{prefix}/include/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/lib/clang #{prefix}/lib/"
    system "/bin/sh", "-c", "cp -r #{buildpath}/builddir/lib/libcling.dylib #{prefix}/lib/"
  end

  test do
  end
end
