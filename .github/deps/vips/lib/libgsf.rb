class Libgsf < Formula
  desc "I/O abstraction library for dealing with structured file formats"
  homepage "https://gitlab.gnome.org/GNOME/libgsf"
  url "https://download.gnome.org/sources/libgsf/1.14/libgsf-1.14.51.tar.xz"
  sha256 "f0b83251f98b0fd5592b11895910cc0e19f798110b389aba7da1cb7c474017f5"
  license "LGPL-2.1-only"

  bottle do
    sha256 arm64_sonoma:   "5876775a2c3d1c2bfc0b6c0ccbfb450b1fb7c6bc1574fbf4319ac0345cf52101"
    sha256 arm64_ventura:  "7497ba9538d387da4c62d7197f9e65c03d4bc53e54740263162294967e9c82b2"
    sha256 arm64_monterey: "7921d046e4345784dc643a6d71f94b106533bbcc0784e7691e9fd57b0750a419"
    sha256 sonoma:         "9188b16c82c96a57f13850e836e5d40a52605a3ad44651407e5ac2ce598785e6"
    sha256 ventura:        "14648d1ed933c2f8ad25977b03c7f6e975cf89b415a7b0dd02d763902fda84ff"
    sha256 monterey:       "36124acaaedb3101f0b4a8c8e66516891d78ba2e8da3680c30a927ad9d260418"
    sha256 x86_64_linux:   "aa67ee36afbfe57f9760e70cbe6c8ecab479b26e4f992cd704a1aeac52377c3a"
  end

  head do
    url "https://github.com/GNOME/libgsf.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    depends_on "gtk-doc" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "glib"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
  end

  def install
    configure = build.head? ? "./autogen.sh" : "./configure"
    system configure, *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"gsf", "--help"
    (testpath/"test.c").write <<~EOS
      #include <gsf/gsf-utils.h>
      int main()
      {
          void
          gsf_init (void);
          return 0;
      }
    EOS
    system ENV.cc, "-I#{include}/libgsf-1",
           "-I#{Formula["glib"].opt_include}/glib-2.0",
           "-I#{Formula["glib"].opt_lib}/glib-2.0/include",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
