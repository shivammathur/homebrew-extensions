# typed: true
# frozen_string_literal: true

# Class for Firebird Client
class FirebirdClient < Formula
  env :std if OS.linux?
  desc "Client libraries and headers for Firebird database"
  homepage "https://firebirdsql.org"
  url "https://github.com/FirebirdSQL/firebird/archive/refs/tags/v5.0.4.tar.gz"
  sha256 "7f09ec81a24aea1bc6b02b5d8bd3b8a204fe850eabf66ab97b35d94960bef18d"
  # License references:
  # 1. https://firebirdsql.org/en/interbase-public-license
  # 2. https://www.firebirdsql.org/en/initial-developer-s-public-license-version-1-0/
  license "Interbase-1.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "e3209c0ae065bd0700c65564c3bf1d441edceb1919f43e383e7afd5de4feb41c"
    sha256 cellar: :any, arm64_sequoia: "cd25b0bb1ee6178ca50ecaacb7bfd4cf5bb0553ad19a42d74e4d1d4ba39e368b"
    sha256 cellar: :any, arm64_sonoma:  "021ec1d0d8b02acf893b94faccffd210c8a90b2181c41f917d18e514bf4f776b"
    sha256 cellar: :any, sonoma:        "bf700db2f9e7574f4cfc4bc4f1d4aa855964d43c87d7d2a378995500577fdfc8"
    sha256               arm64_linux:   "a47339eb6c6f06c69897742b80abf25fd664750387aae42b9a7f3892d24ccc60"
    sha256               x86_64_linux:  "77d81e8a552f45d4aa1ddf94b3520e0ca6b697e34b61f136977ff5ee247531c3"
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
    inreplace "src/common/classes/alloc.h",
              "using is_always_equal = typename Alloc::is_always_equal;",
              <<~EOS
                using is_always_equal = typename Alloc::is_always_equal;
                using propagate_on_container_copy_assignment = std::false_type;
                using propagate_on_container_move_assignment = std::false_type;
                using propagate_on_container_swap = std::false_type;
              EOS
    if OS.mac?
      icu_versions = Dir["#{icu_prefix}/lib/libicuuc*.dylib"].filter_map do |path|
        File.basename(path)[/^libicuuc\.(\d+)(?:\.\d+)?\.dylib$/, 1]
      end
      icu_major = icu_versions.max_by(&:to_i)
      odie "Unable to determine ICU major version from #{icu_prefix}/lib" if icu_major.nil?

      inreplace "configure.ac" do |s|
        s.gsub!(%r{@rpath/libicudata\.\d+\.dylib}, "@rpath/libicudata.#{icu_major}.dylib")
        s.gsub!(%r{@rpath/libicuuc\.\d+\.dylib}, "@rpath/libicuuc.#{icu_major}.dylib")
        s.gsub!(/libicuuc\.\d+\.dylib/, "libicuuc.#{icu_major}.dylib")
        s.gsub!(/libicui18n\.\d+\.dylib/, "libicui18n.#{icu_major}.dylib")
      end
    end

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
