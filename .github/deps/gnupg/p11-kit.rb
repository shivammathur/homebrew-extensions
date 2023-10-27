class P11Kit < Formula
  desc "Library to load and enumerate PKCS#11 modules"
  homepage "https://p11-glue.freedesktop.org"
  url "https://github.com/p11-glue/p11-kit/releases/download/0.25.0/p11-kit-0.25.0.tar.xz"
  sha256 "d55583bcdde83d86579cabe3a8f7f2638675fef01d23cace733ff748fc354706"
  license "BSD-3-Clause"

  bottle do
    rebuild 1
    sha256 arm64_sonoma:   "c27ac6b9fca3688c75f9759d55fc71a1a0dccb89c5eb1af9af8dd3224bca1783"
    sha256 arm64_ventura:  "c4e8e806b4f9eaff41f046417127e60abbc1e6e67d5eb7167aa0eca447cc4b24"
    sha256 arm64_monterey: "12443dfeed7e36cc3f6eca9ca6def58df243e0340c66933db4cef5c7e2591ea8"
    sha256 sonoma:         "de15bdc8560b69a8c797d6988a197e56017365158290367c8f3bffacd6f41c32"
    sha256 ventura:        "210173ada4b3f872c3dcf497c22758c88ee0182d2505ac167216ca23dc04314d"
    sha256 monterey:       "21d012fa4b20186b9cf2026369f9d221c970ad3326cf58ef994ced1ac3c8f859"
    sha256 x86_64_linux:   "11dffa7e7c055ae5f36b90621aba79d137601735dc3f1d1d96dfeddf4d846e5b"
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
