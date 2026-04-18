# typed: true
# frozen_string_literal: true

# Class for Firebird Client 3.x
class FirebirdClientAT3 < Formula
  env :std if OS.linux?
  desc "Client libraries and headers for Firebird database"
  homepage "https://firebirdsql.org"
  url "https://github.com/FirebirdSQL/firebird/archive/refs/tags/v3.0.14.tar.gz"
  sha256 "cd56ccb5801be0d26e62cd7bbbe161c9852a7c181e72ead4036ed75467135b9a"
  # License references:
  # 1. https://firebirdsql.org/en/interbase-public-license
  # 2. https://www.firebirdsql.org/en/initial-developer-s-public-license-version-1-0/
  license "Interbase-1.0"

  livecheck do
    url "https://github.com/FirebirdSQL/firebird/tags"
    regex(/^v?(3\.0\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8f315f04098f199f3ba8fa380a555edc4d8fc76c7187a3a907b825fac4f771e0"
    sha256 cellar: :any, arm64_sequoia: "7f2ff665e636714b8548119efa8c0f4048507f05b4cfd6c6d472888af58b415d"
    sha256 cellar: :any, arm64_sonoma:  "041eff70ca6b81010338ac8020d18b120356236fbc6f291c92e6636158bbfc91"
    sha256 cellar: :any, sonoma:        "936c22d554d42636192c96df9274969ec87656d4e683f92cdbec547c533a1f45"
    sha256               arm64_linux:   "f282353a209e6017d1a6868aebbe874e0f63057f963fd902eb7212c1fb8e070c"
    sha256               x86_64_linux:  "e71f39c8e632aa82151f446d62872605c50e82616df86b87367125c48c8bbaab"
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

    # Firebird's POSIX make rules incorrectly compile root-level C++ sources
    # (like examples/udr/*.cpp) with CC/WCFLAGS. Modern Homebrew superenv adds
    # C-only flags such as -std=gnu23 to CC, which breaks those C++ objects.
    make_rules = buildpath/"builds/posix/make.rules"
    if make_rules.exist?
      content = make_rules.read
      content.gsub!(%r{(\$\(OBJ\)/%\.o: \$\(ROOT\)/%\.cpp\n)\t\$\(CC\) \$\(WCFLAGS\)},
                    "\\1\t$(CXX) $(WCXXFLAGS)")
      make_rules.atomic_write(content)
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
