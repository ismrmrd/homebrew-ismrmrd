require "formula"

class Ismrmrd < Formula
  homepage "https://ismrmrd.github.io"
  url "https://github.com/ismrmrd/ismrmrd/archive/v1.2.3.tar.gz"
  sha1 "4e74839adabcc62a7f530038c18e07c56abec05b"

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
