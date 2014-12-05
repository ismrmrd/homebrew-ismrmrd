require "formula"

class Ismrmrd < Formula
  homepage "https://ismrmrd.github.io"
  url "https://github.com/ismrmrd/ismrmrd/releases/download/v1.1.0-beta-1/ismrmrd-1.1.0-beta-1.tar.gz"
  sha1 "a7e0e20114e9388ca09ef76343054c6ca9d3203c"
  version "1.1.0-beta-1"

  depends_on 'cmake' => :build
  depends_on 'git'
  depends_on 'hdf5'
  depends_on 'boost' => :recommended
  depends_on 'fftw' => :recommended
  depends_on 'doxygen' => :recommended
  depends_on :python => :optional

  def install
    ENV["ISMRMRD_HOME"] = "#{prefix}"

    mkdir 'ismrmrd-build' do
        system "cmake", "..", *std_cmake_args
        system "make", "install"
    end

    if build.with? 'python'
      cd 'bindings/python' do
        system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
      end
    end
  end

  #test do
  #    system "#{bin}/ismrmrd_create_dataset"
  #    system "#{bin}/ismrmrd_recon_dataset", "testdata.h5", "#{prefix}/schema/ismrmrd.xsd"
  #end

  #test do
  #    make test
  #end

  def caveats; <<-EOS.undent
    Export the following environment variable in your shell profile:
      ISMRMRD_HOME=#{prefix}
    EOS
  end

end
