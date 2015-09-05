class Prism < Formula
  desc "Probabilistic model checker"
  homepage "http://www.prismmodelchecker.org"
  url "http://www.prismmodelchecker.org/dl/prism-4.3.beta-src.tar.gz"
  sha256 "f38043e1e82b0f99aab324b411f6d685523f4aef566e9cc7558983ca849c631e"

  depends_on :java => "1.7+"

  def install
    ENV.deparallelize

    system "make"

    inreplace "bin/prism", pwd, prefix
    inreplace "bin/xprism", pwd, prefix

    rm_f ["install.sh", "Makefile"]
    rm_rf ["cudd", "ext", "include", "obj", "src"]

    prefix.install Dir["*"]
  end

  test do
    (testpath/"test.nm").write <<-EOS.undent
      mdp
      module M1
        x : [0..2] init 0;
        [] x=0 -> 0.8:(x'=0) + 0.2:(x'=1);
        [] x=1 & y!=2 -> (x'=2);
        [] x=2 -> 0.5:(x'=2) + 0.5:(x'=0);
      endmodule
      module M2 = M1 [ x=y, y=x ] endmodule
    EOS
    system "#{bin}/prism test.nm -pf 'P>=1 [ G !(x=2 & y=2) ]' | grep 'Result: true'"
  end
end
