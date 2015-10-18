class GnuradioOsmosdr < Formula
  desc "osmocom Gnu Radio Blocks"
  homepage "http://sdr.osmocom.org/trac/wiki/GrOsmoSDR"

  stable do
    url "http://cgit.osmocom.org/gr-osmosdr/snapshot/gr-osmosdr-0.1.4.tar.gz"
    sha256 "5df3faa49e76a9f66a37755f20b5c9238550f913b0dbd9214f811415ec61b1b3"
  end

  # Replace -lpython with -undefined dynamic_lookup in linker flags
  patch :DATA

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "gnuradio"

  resource "Cheetah" do
    url "https://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz"
    sha256 "be308229f0c1e5e5af4f27d7ee06d90bb19e6af3059794e5fd536a6f29a9b550"
  end

  def install
    ENV["CHEETAH_INSTALL_WITHOUT_SETUPTOOLS"] = "1"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    resource("Cheetah").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end
end

__END__
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -203,6 +203,10 @@ add_custom_target(uninstall
 find_package(PythonLibs 2)
 find_package(SWIG)

+if(APPLE)
+    set(PYTHON_LIBRARY "-undefined dynamic_lookup")
+endif(APPLE)
+
 if(SWIG_FOUND)
     message(STATUS "Minimum SWIG version required is 1.3.31")
     set(SWIG_VERSION_CHECK FALSE)
