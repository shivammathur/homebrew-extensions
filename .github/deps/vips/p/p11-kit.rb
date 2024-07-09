class P11Kit < Formula
  desc "Library to load and enumerate PKCS#11 modules"
  homepage "https://p11-glue.freedesktop.org"
  url "https://github.com/p11-glue/p11-kit/releases/download/0.25.4/p11-kit-0.25.4.tar.xz"
  sha256 "4c4153f81167444ff6d5e7ca118472ae607bd25c0cf6346fcc5dcc30451e97ce"
  license "BSD-3-Clause"

  bottle do
    sha256 arm64_sonoma:   "e901220d8fb3824f261dc9773131249cdab2ec10119c758ed70ab3f3d843d790"
    sha256 arm64_ventura:  "d29d433e272014c612aba22210c730907b79302c3bb5864cffb094a760644746"
    sha256 arm64_monterey: "ab751f6e400df153f1ecc7b91a250dce68eb94aa602a190184426d3fec7e7442"
    sha256 sonoma:         "001cf44d0044a0d06e8bc18c06a3b658bf70eef0c5cbf738b4366b355090bbc4"
    sha256 ventura:        "56ad10f3931ff9d4a2fd81b0a201dc3304ac2871fd167aee12a6aaa2ab5416e6"
    sha256 monterey:       "96252329231c5a9ec2f46ae8cbd63674a9bd035028b7e7afa0dd8053994aeb97"
    sha256 x86_64_linux:   "5c64614d0aabea975032407ff48bf5059130e039089fab4f9e32f78a939cb7e7"
  end

  head do
    url "https://github.com/p11-glue/p11-kit.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    depends_on "libtool" => :build
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "ca-certificates"
  depends_on "libtasn1"

  uses_from_macos "libffi", since: :catalina

  def install
    # https://bugs.freedesktop.org/show_bug.cgi?id=91602#c1
    ENV["FAKED_MODE"] = "1"

    if build.head?
      ENV["NOCONFIGURE"] = "1"
      system "./autogen.sh"
    end

    args = %W[
      -Dsystem_config=#{etc}
      -Dmodule_config=#{etc}/pkcs11/modules
      -Dtrust_paths=#{etc}/ca-certificates/cert.pem"
      -Dsystemd=disabled
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    # This formula is used with crypto libraries, so let's run the test suite.
    system "meson", "test", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/p11-kit", "list-modules"
  end
end
