class Libx11 < Formula
  desc "X.Org: Core X11 protocol client library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libX11-1.8.11.tar.gz"
  sha256 "17a37d1597354a1d8040196f1cdac54240c78c0bd1a1a95e97cc23215cf0b734"
  license "MIT"

  bottle do
    sha256 arm64_sequoia: "defefa00e824a71099e3dae6bbf18ae7bd728f7adacba32be6b0ef9d6fd12cf2"
    sha256 arm64_sonoma:  "bb1a33c1c0966d28ac136dac6b3a0d740b36b7ba51fad7d9c42e3d774b716692"
    sha256 arm64_ventura: "2ba31edc61c380648ed600dccb7b70360c20856f9a47b8fc8d3af1411ac41874"
    sha256 sonoma:        "6b8485b5b6fcb5232223a37a79276fd91f7aafe0cf7a968ed2abc98f794319bb"
    sha256 ventura:       "96fce96bc5aeb7bc1b0259c99fd4abaa4d2d17a9d759e510a7e2c70427c7e309"
    sha256 x86_64_linux:  "89c0d132797463adc612aa6af445f50e0b07c0314aba4f0127d35f83cd5c503b"
  end

  depends_on "pkgconf" => :build
  depends_on "util-macros" => :build
  depends_on "xtrans" => :build
  depends_on "libxcb"
  depends_on "xorgproto"

  def install
    ENV.delete "LC_ALL"
    ENV["LC_CTYPE"] = "C"
    args = %W[
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-loadable-i18n
      --enable-xthreads
      --enable-specs=no
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <X11/Xlib.h>
      #include <stdio.h>
      int main() {
        Display* disp = XOpenDisplay(NULL);
        if (disp == NULL)
        {
          fprintf(stderr, "Unable to connect to display\\n");
          return 0;
        }

        int screen_num = DefaultScreen(disp);
        unsigned long background = BlackPixel(disp, screen_num);
        unsigned long border = WhitePixel(disp, screen_num);
        int width = 60, height = 40;
        Window win = XCreateSimpleWindow(disp, DefaultRootWindow(disp), 0, 0, width, height, 2, border, background);
        XSelectInput(disp, win, ButtonPressMask|StructureNotifyMask);
        XMapWindow(disp, win); // display blank window

        XGCValues values;
        values.foreground = WhitePixel(disp, screen_num);
        values.line_width = 1;
        values.line_style = LineSolid;
        GC pen = XCreateGC(disp, win, GCForeground|GCLineWidth|GCLineStyle, &values);
        // draw two diagonal lines
        XDrawLine(disp, win, pen, 0, 0, width, height);
        XDrawLine(disp, win, pen, width, 0, 0, height);

        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lX11", "-o", "test", "-I#{include}"
    system "./test"
  end
end
