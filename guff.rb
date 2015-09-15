class Guff < Formula
  desc "Plot device"
  homepage "https://github.com/silentbicycle/guff"
  url "https://github.com/silentbicycle/guff/archive/v0.1.0.tar.gz"
  sha256 "5d4373baf89f5e2cca1812eb067c0dda6025f3138daf0f5de4d2e859362c0398"
  head "https://github.com/silentbicycle/guff.git"

  def install
    system "make"

    bin.install "guff"
    (libexec/"bin").install "test_guff"
    man1.install Dir["man/*"]
  end

  test do
    system "#{libexec}/bin/test_guff"
  end
end
