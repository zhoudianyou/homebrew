class Fwknop < Formula
  homepage "http://www.cipherdyne.org/fwknop/"
  head "https://github.com/mrash/fwknop.git"
  url "https://github.com/mrash/fwknop/archive/2.6.5.tar.gz"
  sha1 "52f5a191f37aeeb2716d2ad5a25dbf41d6593100"

  bottle do
    sha1 "f59415c1d1381e55fdd480a87dc192900d64324f" => :yosemite
    sha1 "9c82b902d1289ab3d3070d430f751f7a1e7c00aa" => :mavericks
    sha1 "19cc832e0b839f7369713cd2735f1d4258e0338c" => :mountain_lion
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "wget" => :optional
  depends_on "gpgme"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--disable-silent-rules",
                          "--prefix=#{prefix}", "--with-gpgme", "--sysconfdir=#{etc}",
                          "--with-gpg=#{Formula["gnupg2"].opt_prefix}/bin/gpg2"
    system "make", "install"
  end

  test do
    ENV["HOME"] = testpath
    touch testpath/".fwknoprc"
    chmod 0600, testpath/".fwknoprc"
    system "#{bin}/fwknop", "--version"
  end
end
