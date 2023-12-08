class Glib < Formula
  include Language::Python::Shebang

  desc "Core application library for C"
  homepage "https://developer.gnome.org/glib/"
  url "https://download.gnome.org/sources/glib/2.78/glib-2.78.2.tar.xz"
  sha256 "4409eb63f7711a45e70c3b5ff5b42214ef2df056c254228bef4e45f4b6b74b12"
  license "LGPL-2.1-or-later"

  bottle do
    sha256 arm64_sonoma:   "dc1bb3d78fd901741067b04391347e5d2fef8ba48e3fe9315e3065d402f104fa"
    sha256 arm64_ventura:  "26a1f5942a25a02b0f80103f9425fdbbeda6b7bb724343d68abf0edeba1de2da"
    sha256 arm64_monterey: "6fd5b566a577f1000a15912a36d48e9e3919e6b397a7f9efb4ac864071109a6a"
    sha256 sonoma:         "f1a3c1e0ddc6869a900531e94d5380838d03b99df110071f5991e0205879039b"
    sha256 ventura:        "e67f056b7f9766304377220132dba0af53f1cca9ee08eff83aa582d48e68f641"
    sha256 monterey:       "00923c1a7eb3a5843f4c25f305716cf570f00331b1881fd85a3df61da5a34485"
    sha256 x86_64_linux:   "a102ddadc1afcdd61514ef86a449c6cc2dac6b8c492df4aca5fd4fa1c7a0c292"
  end

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python-setuptools" => :build
  depends_on "pcre2"

  uses_from_macos "libffi", since: :catalina
  uses_from_macos "python", since: :catalina

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "dbus"
    depends_on "util-linux"
  end

  # These used to live in the now defunct `glib-utils`.
  link_overwrite "bin/gdbus-codegen", "bin/glib-genmarshal", "bin/glib-mkenums", "bin/gtester-report"
  link_overwrite "share/glib-2.0/codegen", "share/glib-2.0/gdb"

  # replace several hardcoded paths with homebrew counterparts
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/43467fd8dfc0e8954892ecc08fab131242dca025/glib/hardcoded-paths.diff"
    sha256 "d81c9e8296ec5b53b4ead6917f174b06026eeb0c671dfffc4965b2271fb6a82c"
  end

  def install
    inreplace %w[gio/xdgmime/xdgmime.c glib/gutils.c], "@@HOMEBREW_PREFIX@@", HOMEBREW_PREFIX
    # Avoid the sandbox violation when an empty directory is created outside of the formula prefix.
    inreplace "gio/meson.build", "install_emptydir(glib_giomodulesdir)", ""

    # Disable dtrace; see https://trac.macports.org/ticket/30413
    # and https://gitlab.gnome.org/GNOME/glib/-/issues/653
    args = %W[
      --default-library=both
      --localstatedir=#{var}
      -Dgio_module_dir=#{HOMEBREW_PREFIX}/lib/gio/modules
      -Dbsymbolic_functions=false
      -Ddtrace=false
      -Druntime_dir=#{var}/run
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    # ensure giomoduledir contains prefix, as this pkgconfig variable will be
    # used by glib-networking and glib-openssl to determine where to install
    # their modules
    inreplace lib/"pkgconfig/gio-2.0.pc",
              "giomoduledir=#{HOMEBREW_PREFIX}/lib/gio/modules",
              "giomoduledir=${libdir}/gio/modules"

    if OS.mac?
      # `pkg-config --libs glib-2.0` includes -lintl, and gettext itself does not
      # have a pkgconfig file, so we add gettext lib and include paths here.
      gettext = Formula["gettext"].opt_prefix
      inreplace lib/"pkgconfig/glib-2.0.pc" do |s|
        s.gsub! "Libs: -L${libdir} -lglib-2.0 -lintl",
                "Libs: -L${libdir} -lglib-2.0 -L#{gettext}/lib -lintl"
        s.gsub! "Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include",
                "Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I#{gettext}/include"
      end
    end

    if MacOS.version < :catalina
      # `pkg-config --print-requires-private gobject-2.0` includes libffi,
      # but that package is keg-only so it needs to look for the pkgconfig file
      # in libffi's opt path.
      libffi = Formula["libffi"].opt_prefix
      inreplace lib/"pkgconfig/gobject-2.0.pc" do |s|
        s.gsub! "Requires.private: libffi",
                "Requires.private: #{libffi}/lib/pkgconfig/libffi.pc"
      end
    end

    rm "gio/completion/.gitignore"
    bash_completion.install (buildpath/"gio/completion").children
    rewrite_shebang detected_python_shebang(use_python_from_path: true), *bin.children
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/gio/modules").mkpath
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <string.h>
      #include <glib.h>

      int main(void)
      {
          gchar *result_1, *result_2;
          char *str = "string";

          result_1 = g_convert(str, strlen(str), "ASCII", "UTF-8", NULL, NULL, NULL);
          result_2 = g_convert(result_1, strlen(result_1), "UTF-8", "ASCII", NULL, NULL, NULL);

          return (strcmp(str, result_2) == 0) ? 0 : 1;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-I#{include}/glib-2.0",
                   "-I#{lib}/glib-2.0/include", "-L#{lib}", "-lglib-2.0"
    system "./test"

    assert_match "This file is generated by glib-mkenum", shell_output("#{bin}/glib-mkenums")
  end
end
