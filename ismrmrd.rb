require "formula"

class Ismrmrd < Formula
  homepage "https://ismrmrd.github.io"
  url "https://github.com/ismrmrd/ismrmrd/archive/v1.2.0.tar.gz"
  sha1 "767e846d6bf53391085647a27f785989dd05561e"
  #version "1.2.0"

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

    if build.with? "python"
      cd "bindings/python" do
        system "python", *Language::Python.setup_install_args(prefix)
      end
    end
  end

  test do
      system "#{bin}/ismrmrd_generate_cartesian_shepp_logan"
      system "#{bin}/ismrmrd_recon_cartesian_2d", "testdata.h5"
  end

  def caveats; <<-EOS.undent
    Export the following environment variable in your shell profile:
      ISMRMRD_HOME=#{prefix}
    EOS
  end

end
