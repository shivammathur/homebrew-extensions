class Libxcb < Formula
  desc "X.Org: Interface to the X Window System protocol"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.16.tar.xz"
  sha256 "4348566aa0fbf196db5e0a576321c65966189210cb51328ea2bb2be39c711d71"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "f9b6be27d8ad4fe5e599747d36d068817c034262c80608b4c98c4b8af67bf374"
    sha256 cellar: :any,                 arm64_ventura:  "fdebe13a04434a1c531a05a96d73690aaa77450d14a4aab059641b71f1ece75f"
    sha256 cellar: :any,                 arm64_monterey: "b0999ac7afa5248993eb4461ac28c92b444f962928dfde615480f10df24e386c"
    sha256 cellar: :any,                 sonoma:         "0fe2f8cf12ca0fb252dbc5ad87d38d0b0bb9dfa03c848453796deb6352422839"
    sha256 cellar: :any,                 ventura:        "e501531b388f9e218fc6deacfdf24f6b7daf922d82a7cade6838bddd0ac866ce"
    sha256 cellar: :any,                 monterey:       "7df566b634d6266fbcc10bae41e98b535a92cf8baea722312b70ba521497c3c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8ab80d0da10993364e138368eb8ca1882fe6c9217a0b7d1f5646c7bf1e82cfb"
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.12" => :build # match version in `xcb-proto`
  depends_on "xcb-proto" => :build
  depends_on "libxau"
  depends_on "libxdmcp"

  def install
    python3 = "python3.12"

    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-dri3
      --enable-ge
      --enable-xevie
      --enable-xprint
      --enable-selinux
      --disable-silent-rules
      --enable-devel-docs=no
      --with-doxygen=no
      PYTHON=#{python3}
    ]

    system "./configure", *std_configure_args, *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdlib.h>
      #include <string.h>
      #include "xcb/xcb.h"

      int main() {
        xcb_connection_t *connection;
        xcb_atom_t *atoms;
        xcb_intern_atom_cookie_t *cookies;
        int count, i;
        char **names;
        char buf[100];

        count = 200;

        connection = xcb_connect(NULL, NULL);
        atoms = (xcb_atom_t *) malloc(count * sizeof(atoms));
        names = (char **) malloc(count * sizeof(char *));

        for (i = 0; i < count; ++i) {
          sprintf(buf, "NAME%d", i);
          names[i] = strdup(buf);
          memset(buf, 0, sizeof(buf));
        }

        cookies = (xcb_intern_atom_cookie_t *) malloc(count * sizeof(xcb_intern_atom_cookie_t));

        for(i = 0; i < count; ++i) {
          cookies[i] = xcb_intern_atom(connection, 0, strlen(names[i]), names[i]);
        }

        for(i = 0; i < count; ++i) {
          xcb_intern_atom_reply_t *r;
          r = xcb_intern_atom_reply(connection, cookies[i], 0);
          if(r)
            atoms[i] = r->atom;
          free(r);
        }

        free(atoms);
        free(cookies);
        xcb_disconnect(connection);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lxcb"
    system "./test"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
