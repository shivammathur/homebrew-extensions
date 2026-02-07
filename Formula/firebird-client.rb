# typed: true
# frozen_string_literal: true

# Class for Firebird Client
class FirebirdClient < Formula
  env :std if OS.linux?
  desc "Client libraries and headers for Firebird database"
  homepage "https://firebirdsql.org"
  url "https://github.com/FirebirdSQL/firebird/archive/refs/tags/v5.0.3.tar.gz"
  sha256 "626fa67067e7ebf425366667f960a1093d69b4ca5344b3c2fa604b454f7ed139"
  # License references:
  # 1. https://firebirdsql.org/en/interbase-public-license
  # 2. https://www.firebirdsql.org/en/initial-developer-s-public-license-version-1-0/
  license "Interbase-1.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "993d65bbf0338044fa88db1060bcd528595f35a93a1ca094d719be908d7b4f88"
    sha256 cellar: :any, arm64_sequoia: "da144605bb3c01fac214d64618a9c59e77bd6055d20dca769f45507da2271e1e"
    sha256 cellar: :any, arm64_sonoma:  "58489f4ed19002f691d13dea11550e2b88bf11ff7b104a33616a8ed09a437394"
    sha256 cellar: :any, sonoma:        "3708b9a2342b7baa28192e0439d65ab582a15b8395580755e1784977ffbf57b8"
    sha256               arm64_linux:   "5abaec660be75f7b0c75e84f588e8f6b669fee447e305699c8618b714f066835"
    sha256               x86_64_linux:  "e31242d85dab7ea43bc42d3b73c743269ab4d2a5f610bdecd4525aecae130317"
  end
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "boost"
  depends_on "icu4c@78"
  depends_on "libedit"
  depends_on "libtomcrypt"
  depends_on "libtommath"

  def install
    icu_prefix = Formula["icu4c@78"].opt_prefix
    tommath_prefix = Formula["libtommath"].opt_prefix
    tomcrypt_prefix = Formula["libtomcrypt"].opt_prefix
    fb_build_lib = buildpath/"gen/Release/firebird/lib"
    fb_build_lib.mkpath
    icu_glob = OS.mac? ? "libicu*.dylib" : "libicu*.so*"
    Dir["#{icu_prefix}/lib/#{icu_glob}"].each { |library| cp library, fb_build_lib }
    tommath_glob = OS.mac? ? "libtommath*.dylib*" : "libtommath.so*"
    Dir["#{tommath_prefix}/lib/#{tommath_glob}"].each { |library| cp library, fb_build_lib }
    tomcrypt_glob = OS.mac? ? "libtomcrypt*.dylib*" : "libtomcrypt.so*"
    Dir["#{tomcrypt_prefix}/lib/#{tomcrypt_glob}"].each { |library| cp library, fb_build_lib }

    inreplace "configure.ac", "VCPKG_TRIPLET=fb-arm64-osx", "VCPKG_TRIPLET="
    inreplace "configure.ac", "VCPKG_TRIPLET=fb-x64-osx", "VCPKG_TRIPLET="
    inreplace "autogen.sh", "LIBTOOLIZE=libtoolize", "LIBTOOLIZE=glibtoolize" if OS.mac?

    args = [
      "--prefix=#{prefix}",
      "--disable-rpath",
      "--with-gpre-cobol",
      "--with-system-boost",
      "--with-system-editline",
      "CPPFLAGS=-I#{icu_prefix}/include -I#{tommath_prefix}/include -I#{tomcrypt_prefix}/include",
      "LDFLAGS=-L#{icu_prefix}/lib -L#{tommath_prefix}/lib -L#{tomcrypt_prefix}/lib",
    ]
    args.unshift("VCPKG_INSTALLED=#{MacOS.sdk_path}/usr") if OS.mac?
    system "./autogen.sh", *args
    system "make"

    fb_release = buildpath/"gen/Release/firebird"
    lib.mkpath
    include.mkpath

    cp_r "#{fb_release}/include/.", include if (fb_release/"include").directory?
    cp_r "#{buildpath}/src/include/firebird", include if (buildpath/"src/include/firebird").directory?

    %w[ibase.h iberror.h ib_util.h].each do |header|
      header_path = buildpath/"src/include"/header
      cp header_path, include if header_path.exist?
    end

    if OS.mac?
      unversioned = fb_release/"lib/libfbclient.dylib"
      if unversioned.exist?
        cp unversioned, lib/"libfbclient.dylib"
      else
        dylibs = Dir["#{fb_release}/lib/libfbclient.dylib*"]
        odie "libfbclient.dylib was not built" if dylibs.empty?
        cp dylibs.max, lib/"libfbclient.dylib"
      end
    else
      sofiles = Dir["#{fb_release}/lib/libfbclient.so*"]
      sofiles.each { |library| cp library, lib }
      unless (lib/"libfbclient.so").exist?
        versioned = Dir["#{lib}/libfbclient.so*"].reject { |path| path.end_with?("libfbclient.so") }
        ln_sf Pathname.new(versioned.max).basename, lib/"libfbclient.so" if versioned.any?
      end
    end
  end

  test do
    expected = OS.mac? ? lib/"libfbclient.dylib" : lib/"libfbclient.so"
    assert_path_exists expected
  end
end
