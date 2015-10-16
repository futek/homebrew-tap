class Gqrx < Formula
  desc "Software defined radio receiver powered by GNU Radio and Qt"
  homepage "http://gqrx.dk"
  head "https://github.com/csete/gqrx.git"

  stable do
    url "https://github.com/csete/gqrx/archive/v2.3.2.tar.gz"
    sha256 "2748ee14491dbfb5821efba32300124b5a2b0aabc810cdfda91e5f64bd3502cf"
  end

  depends_on "qt"
  depends_on "gnuradio"
  depends_on "gnuradio-osmosdr"

  def install
    mkdir "build" do
      system "qmake", "..", "PREFIX=#{prefix}"
      system "make"
      system "make", "install"
      prefix.install bin/"Gqrx.app"
    end
  end
end
