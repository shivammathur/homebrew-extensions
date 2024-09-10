class Glib < Formula
  include Language::Python::Shebang

  desc "Core application library for C"
  homepage "https://docs.gtk.org/glib/"
  url "https://download.gnome.org/sources/glib/2.82/glib-2.82.0.tar.xz"
  sha256 "f4c82ada51366bddace49d7ba54b33b4e4d6067afa3008e4847f41cb9b5c38d3"
  license "LGPL-2.1-or-later"

  bottle do
    sha256 arm64_sequoia:  "fabde59fd4ed3dd1168b9fcb2c7ad2962ac6862b2cbf75b2c79e0d3ad16a204a"
    sha256 arm64_sonoma:   "4047dfc944e3dc37dfe960135d7db67ab8c8422ed311787d894cae93dba02b37"
    sha256 arm64_ventura:  "3a15a1b25c99c4c391329d0233a939d77caae3855cb203e7918ffa9be9254e02"
    sha256 arm64_monterey: "5b44345a0a91d94d9e4fc196ccfcfe05cdb47c1f986cdf285aac1f69270df213"
    sha256 sonoma:         "805d2a6a335c180f53fd3969b3d16d9ee28c787b415fbdad8fbc777196011c1a"
    sha256 ventura:        "8f5e08e3c5f963536f5f81cc810d0a2a40c457c4a5f42d8f33ebf603214b3597"
    sha256 monterey:       "9b9af94e4333899c424e3464550acb4294a24290fa491551f9b690317ac2e7b3"
    sha256 x86_64_linux:   "0d30e9405f5ae1ae74ac73618b3b3fff37b42eea1f9262a1df192ba4059eaab4"
  end

  depends_on "bison" => :build # for gobject-introspection
  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python-setuptools" => :build # for gobject-introspection
  depends_on "pcre2"
  depends_on "python@3.12"

  uses_from_macos "flex" => :build # for gobject-introspection
  uses_from_macos "libffi", since: :catalina

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
  # These used to live in `gobject-introspection`
  link_overwrite "lib/girepository-1.0/GLib-2.0.typelib", "lib/girepository-1.0/GModule-2.0.typelib",
                 "lib/girepository-1.0/GObject-2.0.typelib", "lib/girepository-1.0/Gio-2.0.typelib"
  link_overwrite "share/gir-1.0/GLib-2.0.gir", "share/gir-1.0/GModule-2.0.gir",
                 "share/gir-1.0/GObject-2.0.gir", "share/gir-1.0/Gio-2.0.gir"

  resource "gobject-introspection" do
    url "https://download.gnome.org/sources/gobject-introspection/1.80/gobject-introspection-1.80.1.tar.xz"
    sha256 "a1df7c424e15bda1ab639c00e9051b9adf5cea1a9e512f8a603b53cd199bc6d8"

    # Backport removed distutils.msvccompiler
    patch do
      url "https://gitlab.gnome.org/GNOME/gobject-introspection/-/commit/a2139dba59eac283a7f543ed737f038deebddc19.diff"
      sha256 "62c1e9816effdb2f2d50bc577ea36b875cdd5e38f67ddb27eb0e0c380fa29700"
    end
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/51/65/50db4dda066951078f0a96cf12f4b9ada6e4b811516bf0262c0f4f7064d4/packaging-24.1.tar.gz"
    sha256 "026ed72c8ed3fcce5bf8950572258698927fd1dbda10a5e981cdf0ac37f4f002"
  end

  # replace several hardcoded paths with homebrew counterparts
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/43467fd8dfc0e8954892ecc08fab131242dca025/glib/hardcoded-paths.diff"
    sha256 "d81c9e8296ec5b53b4ead6917f174b06026eeb0c671dfffc4965b2271fb6a82c"
  end

  def install
    inreplace %w[gio/xdgmime/xdgmime.c glib/gutils.c], "@@HOMEBREW_PREFIX@@", HOMEBREW_PREFIX
    # Avoid the sandbox violation when an empty directory is created outside of the formula prefix.
    inreplace "gio/meson.build", "install_emptydir(glib_giomodulesdir)", ""

    # We don't use a venv as virtualenv_create runs `ENV.refurbish_args`. This causes `gint64`
    # to be detected as `long` rather than `long long` on macOS which mismatches with `int64_t`.
    # Although documented as valid (https://docs.gtk.org/glib/types.html#gint64), it can cause
    # ABI breakage if type changes between releases (e.g. seen in `glibmm@2.66`) and it breaks
    # assumptions made by some dependents. Also, GNOME prefers equivalence of types but cannot
    # require it due to ABI impact - https://gitlab.gnome.org/GNOME/glib/-/merge_requests/2841
    resource("packaging").stage do
      system "python3.12", "-m", "pip", "install", "--target", share/"glib-2.0",
                                                   *std_pip_args(prefix: false, build_isolation: true), "."
    end
    ENV.prepend_path "PYTHONPATH", share/"glib-2.0"

    # build patch for `ld: missing LC_LOAD_DYLIB (must link with at least libSystem.dylib) \
    # in ../gobject-introspection-1.80.1/build/tests/offsets/liboffsets-1.0.1.dylib`
    ENV.append "LDFLAGS", "-Wl,-ld_classic" if OS.mac? && MacOS.version == :ventura

    # Disable dtrace; see https://trac.macports.org/ticket/30413
    # and https://gitlab.gnome.org/GNOME/glib/-/issues/653
    args = %W[
      --localstatedir=#{var}
      -Dgio_module_dir=#{HOMEBREW_PREFIX}/lib/gio/modules
      -Dbsymbolic_functions=false
      -Ddtrace=false
      -Druntime_dir=#{var}/run
      -Dtests=false
    ]

    # Stage build in order to deal with circular dependency as `gobject-introspection`
    # is needed to generate `glib` introspection data used by dependents; however,
    # `glib` is a dependency of `gobject-introspection`.
    # Ref: https://discourse.gnome.org/t/dealing-with-glib-and-gobject-introspection-circular-dependency/18701
    staging_dir = buildpath/"staging"
    staging_meson_args = std_meson_args.map { |s| s.sub prefix, staging_dir }
    system "meson", "setup", "build_staging", "-Dintrospection=disabled", *args, *staging_meson_args
    system "meson", "compile", "-C", "build_staging", "--verbose"
    system "meson", "install", "-C", "build_staging"
    ENV.append_path "PKG_CONFIG_PATH", staging_dir/"lib/pkgconfig"
    ENV.append_path "LD_LIBRARY_PATH", staging_dir/"lib" if OS.linux?
    resource("gobject-introspection").stage do
      system "meson", "setup", "build", "-Dcairo=disabled", "-Ddoctool=disabled", *staging_meson_args
      system "meson", "compile", "-C", "build", "--verbose"
      system "meson", "install", "-C", "build"
    end
    ENV.append_path "PATH", staging_dir/"bin"

    system "meson", "setup", "build", "--default-library=both", "-Dintrospection=enabled", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    # ensure giomoduledir contains prefix, as this pkgconfig variable will be
    # used by glib-networking and glib-openssl to determine where to install
    # their modules
    inreplace lib/"pkgconfig/gio-2.0.pc",
              "giomoduledir=#{HOMEBREW_PREFIX}/lib/gio/modules",
              "giomoduledir=${libdir}/gio/modules"

    (buildpath/"gio/completion/.gitignore").unlink
    bash_completion.install (buildpath/"gio/completion").children
    rewrite_shebang detected_python_shebang, *bin.children
    return unless OS.mac?

    # `pkg-config --libs glib-2.0` includes -lintl, and gettext itself does not
    # have a pkgconfig file, so we add gettext lib and include paths here.
    gettext = Formula["gettext"]
    inreplace lib/"pkgconfig/glib-2.0.pc" do |s|
      s.gsub! "Libs: -L${libdir} -lglib-2.0 -lintl",
              "Libs: -L${libdir} -lglib-2.0 -L#{gettext.opt_lib} -lintl"
      s.gsub! "Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include",
              "Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I#{gettext.opt_include}"
    end
    return if MacOS.version >= :catalina

    # `pkg-config --print-requires-private gobject-2.0` includes libffi,
    # but that package is keg-only so it needs to look for the pkgconfig file
    # in libffi's opt path.
    inreplace lib/"pkgconfig/gobject-2.0.pc",
              "Requires.private: libffi",
              "Requires.private: #{Formula["libffi"].opt_lib}/pkgconfig/libffi.pc"
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

    assert_match "This file is generated by glib-mkenum", shell_output(bin/"glib-mkenums")

    (testpath/"net.Corp.MyApp.Frobber.xml").write <<~EOS
      <node>
        <interface name="net.Corp.MyApp.Frobber">
          <method name="HelloWorld">
            <arg name="greeting" direction="in" type="s"/>
            <arg name="response" direction="out" type="s"/>
          </method>

          <signal name="Notification">
            <arg name="icon_blob" type="ay"/>
            <arg name="height" type="i"/>
            <arg name="messages" type="as"/>
          </signal>

          <property name="Verbose" type="b" access="readwrite"/>
        </interface>
      </node>
    EOS

    system bin/"gdbus-codegen", "--generate-c-code", "myapp-generated",
                                "--c-namespace", "MyApp",
                                "--interface-prefix", "net.corp.MyApp.",
                                "net.Corp.MyApp.Frobber.xml"
    assert_predicate testpath/"myapp-generated.c", :exist?
    assert_match "my_app_net_corp_my_app_frobber_call_hello_world", (testpath/"myapp-generated.h").read

    # Keep (u)int64_t and g(u)int64 aligned. See install comment for details
    (testpath/"typecheck.cpp").write <<~EOS
      #include <cstdint>
      #include <type_traits>
      #include <glib.h>

      int main()
      {
        static_assert(std::is_same<int64_t, gint64>::value == true, "gint64 should match int64_t");
        static_assert(std::is_same<uint64_t, guint64>::value == true, "guint64 should match uint64_t");
        return 0;
      }
    EOS
    system ENV.cxx, "-o", "typecheck", "typecheck.cpp", "-I#{include}/glib-2.0", "-I#{lib}/glib-2.0/include"
  end
end
