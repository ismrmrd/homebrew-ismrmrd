require "formula"

class Ismrmrd < Formula
  homepage "https://ismrmrd.github.io"
  url "https://github.com/ismrmrd/ismrmrd/archive/v1.2.0.tar.gz"
  sha1 "767e846d6bf53391085647a27f785989dd05561e"

  depends_on 'cmake' => :build
  depends_on 'hdf5'
  depends_on 'boost' => :recommended
  depends_on 'fftw' => :recommended

  def install
    mkdir 'ismrmrd-build' do
        system "cmake", "..", *std_cmake_args
        system "make", "install"
    end
  end

  test do
      system "ismrmrd_info"
  end

end
