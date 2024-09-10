class Nss < Formula
  desc "Libraries for security-enabled client and server applications"
  homepage "https://firefox-source-docs.mozilla.org/security/nss/index.html"
  url "https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_104_RTM/src/nss-3.104.tar.gz"
  sha256 "e2763223622d1e76b98a43030873856f248af0a41b03b2fa2ca06a91bc50ac8e"
  license "MPL-2.0"

  livecheck do
    url "https://ftp.mozilla.org/pub/security/nss/releases/"
    regex(%r{href=.*?NSS[._-]v?(\d+(?:[._]\d+)+)[._-]RTM/?["' >]}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match.first.tr("_", ".") }
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia:  "81c70cbb8e09eb189d8f04260e1e990bfdd331022c94b9277e9788d6f1183a55"
    sha256 cellar: :any,                 arm64_sonoma:   "fdb2eec983bf3b1c1d104c214cc99a3a3f35f64b8c3229f049e957c6dbaacfb0"
    sha256 cellar: :any,                 arm64_ventura:  "86a106faa1047190cb262dd08d19cb32a55513dd28a2e4bd50641ef2af8ba99f"
    sha256 cellar: :any,                 arm64_monterey: "6e5b16c90009ef80e767b90386080d14572546a47fad5166a4724c622a964932"
    sha256 cellar: :any,                 sonoma:         "be14e298cdda9692d1ca423d1418f4122e677f222a81dccdd269cc350670a533"
    sha256 cellar: :any,                 ventura:        "4943f23aa2401bb0653502b290eff4b6bacd0b16729ca7bff0fb159eaa4ae5bc"
    sha256 cellar: :any,                 monterey:       "b366b3a06f6b1df3f5f543b8785e2889661f9dedd2747637ef14f0edd45759e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e700285b1212337f84f1e2f1b5f2731de0e13df75ed6cfaa5e37310e46990263"
  end

  depends_on "nspr"

  uses_from_macos "sqlite"
  uses_from_macos "zlib"

  conflicts_with "arabica", because: "both install `mangle` binaries"
  conflicts_with "resty", because: "both install `pp` binaries"

  def install
    ENV.deparallelize
    cd "nss"

    args = %W[
      BUILD_OPT=1
      NSS_ALLOW_SSLKEYLOGFILE=1
      NSS_DISABLE_GTESTS=1
      NSS_USE_SYSTEM_SQLITE=1
      NSPR_INCLUDE_DIR=#{Formula["nspr"].opt_include}/nspr
      NSPR_LIB_DIR=#{Formula["nspr"].opt_lib}
      USE_64=1
    ]

    # Remove the broken (for anyone but Firefox) install_name
    inreplace "coreconf/Darwin.mk", "-install_name @executable_path", "-install_name #{lib}"
    inreplace "lib/freebl/config.mk", "@executable_path", lib

    system "make", "all", *args

    # We need to use cp here because all files get cross-linked into the dist
    # hierarchy, and Homebrew's Pathname.install moves the symlink into the keg
    # rather than copying the referenced file.
    cd "../dist"
    bin.mkpath
    os = OS.kernel_name
    Dir.glob("#{os}*/bin/*") do |file|
      cp file, bin unless file.include? ".dylib"
    end

    include_target = include + "nss"
    include_target.mkpath
    Dir.glob("public/{dbm,nss}/*") { |file| cp file, include_target }

    lib.mkpath
    libexec.mkpath
    Dir.glob("#{os}*/lib/*") do |file|
      if file.include? ".chk"
        cp file, libexec
      else
        cp file, lib
      end
    end
    # resolves conflict with openssl, see legacy-homebrew#28258
    rm lib/"libssl.a"

    (bin/"nss-config").write config_file
    (lib/"pkgconfig/nss.pc").write pc_file
  end

  test do
    # See: https://developer.mozilla.org/docs/Mozilla/Projects/NSS/tools/NSS_Tools_certutil
    (testpath/"passwd").write("It's a secret to everyone.")
    system bin/"certutil", "-N", "-d", pwd, "-f", "passwd"
    system bin/"certutil", "-L", "-d", pwd
  end

  # A very minimal nss-config for configuring firefox etc. with this nss,
  # see https://bugzil.la/530672 for the progress of upstream inclusion.
  def config_file
    <<~EOS
      #!/bin/sh
      for opt; do :; done
      case "$opt" in
        --version) opt="--modversion";;
        --cflags|--libs) ;;
        *) exit 1;;
      esac
      pkg-config "$opt" nss
    EOS
  end

  def pc_file
    <<~EOS
      prefix=#{prefix}
      exec_prefix=${prefix}
      libdir=${exec_prefix}/lib
      includedir=${prefix}/include/nss

      Name: NSS
      Description: Mozilla Network Security Services
      Version: #{version}
      Requires: nspr >= 4.12
      Libs: -L${libdir} -lnss3 -lnssutil3 -lsmime3 -lssl3
      Cflags: -I${includedir}
    EOS
  end
end
