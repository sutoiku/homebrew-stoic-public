# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Cling < Formula
  desc "cling build with sutoiku patches"
  homepage "https://github.com/sutoiku/cling"
  url "https://raw.githubusercontent.com/root-project/root/2636379c1d114e2dc80fb7c1ff0a9822dbfeb93b/interpreter/cling/tools/packaging/cpt.py"
  version "0.3.3"
  sha256 ""

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    system "chmod", "+x", "cpt.py"
    system "./cpt.py", "--current-dev=tar",
             "--with-clang-url=http://root.cern.ch/git/clang.git",
             "--with-llvm-url=http://root.cern.ch/git/llvm.git",
             "--with-cling-url=https://github.com/sutoiku/cling.git#v#{version}",
             "--no-test",
             "--skip-cleanup",
             "--with-cmake-flags=-DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_THREADS=OFF -DLLVM_OPTIMIZED_TABLEGEN=ON",
             "--with-workdir=#{buildpath}"

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
