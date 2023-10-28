class P11Kit < Formula
  desc "Library to load and enumerate PKCS#11 modules"
  homepage "https://p11-glue.freedesktop.org"
  url "https://github.com/p11-glue/p11-kit/releases/download/0.25.1/p11-kit-0.25.1.tar.xz"
  sha256 "b6f326925725c8c45484e6daf78cdc73428a86296b6b99078255017f1bacdafc"
  license "BSD-3-Clause"

  bottle do
    sha256 arm64_sonoma:   "a02878900818dd7e88191d7461889a0bf970eebbc69666c6ee12543a7c0c0a09"
    sha256 arm64_ventura:  "858c0d63c966dd8134df696be2dd7933bbb4686866d2df74dac840a6546a2b92"
    sha256 arm64_monterey: "4e059230ed91b0fc9103e77ec7db420810066a26d13923412a4e0cf6d0a7328d"
    sha256 sonoma:         "fb9f396382139bc610aedd4b9c5ce78cddc01a57d6702492e40a4364d8b53665"
    sha256 ventura:        "e8d4c068b631b5561d36a6922987abc00663cf06b2201f4b04d3924f35166d7a"
    sha256 monterey:       "4cb74a8644d66fef3e2d5798920ae72d6722867ab87b613f946f0d190ebefcd7"
    sha256 x86_64_linux:   "bbade4b6f6bbf8c331fe7e274d2f705a3336be0a98408764a6f02094a428a38f"
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
