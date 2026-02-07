# typed: true
# frozen_string_literal: true

# Class for Firebird Client 3.x
class FirebirdClientAT3 < Formula
  env :std if OS.linux?
  desc "Client libraries and headers for Firebird database"
  homepage "https://firebirdsql.org"
  url "https://github.com/FirebirdSQL/firebird/archive/refs/tags/v3.0.13.tar.gz"
  sha256 "7a5e378d4b65f1b4cb03a8da539b72ddc5033f566f6cb2f72184ea1498746b30"
  # License references:
  # 1. https://firebirdsql.org/en/interbase-public-license
  # 2. https://www.firebirdsql.org/en/initial-developer-s-public-license-version-1-0/
  license "Interbase-1.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "93df4677841694469eb477aec878a4934ba1286642831f561505a0c5b5d80236"
    sha256 cellar: :any, arm64_sequoia: "5b8b28d9637a460ed52bb1b78223176f203b60f3f42b2f3a926a4f65885962d7"
    sha256 cellar: :any, arm64_sonoma:  "44466a7d8bd8c689dadf5a04545abc196418733248d809d8781ba051b02d0ef3"
    sha256 cellar: :any, sonoma:        "8d9ea6a989637f52a8af766bb2055fb65c2d6f517e3d1056909df258f7cf5604"
    sha256               arm64_linux:   "4a4e0025ea9270c68bfb28fd09aaa59d0f61429d0070caa7a97d911a999537db"
    sha256               x86_64_linux:  "ed1d34d535e7120a625db3f5238d0bc1c64d24807d19d6e5869ca4b972cd5392"
  end
  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "boost"
  depends_on "icu4c@78"
  depends_on "libedit"
  depends_on "libtommath"

  def install
    icu_prefix = Formula["icu4c@78"].opt_prefix
    tommath_prefix = Formula["libtommath"].opt_prefix
    fb_build_lib = buildpath/"gen/Release/firebird/lib"
    fb_build_lib.mkpath
    icu_glob = OS.mac? ? "libicu*.dylib" : "libicu*.so*"
    Dir["#{icu_prefix}/lib/#{icu_glob}"].each { |library| cp library, fb_build_lib }
    tommath_glob = OS.mac? ? "libtommath*.dylib*" : "libtommath.so*"
    Dir["#{tommath_prefix}/lib/#{tommath_glob}"].each { |library| cp library, fb_build_lib }

    inreplace "autogen.sh", "LIBTOOLIZE=libtoolize", "LIBTOOLIZE=glibtoolize" if OS.mac?
    config_ac = buildpath/"configure.ac"
    if config_ac.exist?
      config_ac_text = config_ac.read
      if config_ac_text.include?("VCPKG_TRIPLET=fb-arm64-osx")
        inreplace config_ac, "VCPKG_TRIPLET=fb-arm64-osx",
"VCPKG_TRIPLET="
      end
      if config_ac_text.include?("VCPKG_TRIPLET=fb-x64-osx")
        inreplace config_ac, "VCPKG_TRIPLET=fb-x64-osx",
"VCPKG_TRIPLET="
      end
    end
    if OS.mac?
      src_darwin_defaults = buildpath/"builds/posix/darwin.defaults"
      if src_darwin_defaults.exist?
        content = src_darwin_defaults.read
        content.gsub!("LIB_LINK_OPTIONS=$(LD_FLAGS) -dynamiclib -flat_namespace",
                      "LIB_LINK_OPTIONS=$(LD_FLAGS) -dynamiclib")
        src_darwin_defaults.atomic_write(content)
      end
    end

    system "./autogen.sh", "--prefix=#{prefix}",
                         "--disable-rpath",
                         "--with-gpre-cobol",
                         "--with-system-editline",
                         "CPPFLAGS=-I#{icu_prefix}/include -I#{tommath_prefix}/include",
                         "LDFLAGS=-L#{icu_prefix}/lib -L#{tommath_prefix}/lib"
    if OS.mac?
      gen_darwin_defaults = buildpath/"gen/darwin.defaults"
      if gen_darwin_defaults.exist?
        content = gen_darwin_defaults.read
        content.gsub!(/(^LIB_LINK_OPTIONS=\$\(LD_FLAGS\)\s+-dynamiclib)\s+-flat_namespace\b/, '\1')
        gen_darwin_defaults.atomic_write(content)
      end

      make_platform = buildpath/"gen/make.platform"
      if make_platform.exist?
        content = make_platform.read
        if content.exclude?("-Wno-c++11-narrowing")
          content.gsub!(/^CXXFLAGS:=(.*)$/, 'CXXFLAGS:=\1 -Wno-c++11-narrowing -Wno-narrowing')
          make_platform.atomic_write(content)
        end
      end
    end
    system "make"

    fb_release = buildpath/"gen/Release/firebird"
    lib.mkpath
    include.mkpath

    cp_r "#{fb_release}/include/.", include if (fb_release/"include").directory?
    cp_r "#{buildpath}/src/include/firebird", include if (buildpath/"src/include/firebird").directory?

    %w[ibase.h iberror.h ib_util.h types_pub.h consts_pub.h].each do |header|
      header_path = buildpath/"src/include"/header
      cp header_path, include if header_path.exist?
    end

    # Firebird 3 ships wrapper headers in src/include that reference
    # generated/legacy paths. Install concrete headers too so consumers
    # can use <ibase.h>/<iberror.h> without extra include-path hacks.
    ibase_real = buildpath/"src/jrd/ibase.h"
    cp ibase_real, include/"ibase.h" if ibase_real.exist?
    iberror_real = buildpath/"src/include/gen/iberror.h"
    if iberror_real.exist?
      cp iberror_real, include/"iberror.h"
      (include/"gen").mkpath
      cp iberror_real, include/"gen/iberror.h"
    end

    blr_header = buildpath/"src/jrd/blr.h"
    cp blr_header, include/"blr.h" if blr_header.exist?

    (prefix/"common").mkpath
    dsc_pub = buildpath/"src/common/dsc_pub.h"
    cp dsc_pub, prefix/"common/dsc_pub.h" if dsc_pub.exist?

    (prefix/"dsql").mkpath
    sqlda_pub = buildpath/"src/dsql/sqlda_pub.h"
    cp sqlda_pub, prefix/"dsql/sqlda_pub.h" if sqlda_pub.exist?

    (prefix/"jrd").mkpath
    inf_pub = buildpath/"src/jrd/inf_pub.h"
    cp inf_pub, prefix/"jrd/inf_pub.h" if inf_pub.exist?

    dylibs = Dir["#{fb_release}/lib/libfbclient*.dylib*"]
    sofiles = Dir["#{fb_release}/lib/libfbclient.so*"]
    lib_candidates = OS.mac? ? dylibs : sofiles
    lib_candidates.each { |library| cp library, lib }

    shared_lib = OS.mac? ? "libfbclient.dylib" : "libfbclient.so"
    unless (lib/shared_lib).exist?
      versioned = Dir["#{lib}/#{shared_lib}*"].reject { |path| path.end_with?(shared_lib) }
      ln_sf Pathname.new(versioned.max).basename, lib/shared_lib if versioned.any?
    end
  end

  test do
    expected = OS.mac? ? lib/"libfbclient.dylib" : lib/"libfbclient.so"
    assert_path_exists expected
  end
end
