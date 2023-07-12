class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "https://www.openldap.org/software/"
  url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.5.tgz"
  mirror "http://fresh-center.net/linux/misc/openldap-2.6.5.tgz"
  mirror "http://fresh-center.net/linux/misc/legacy/openldap-2.6.5.tgz"
  sha256 "2e27a8d4f4c2af8fe840b573271c20aa163e24987f9765214644290f5beb38d9"
  license "OLDAP-2.8"

  livecheck do
    url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/"
    regex(/href=.*?openldap[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_ventura:  "2e42d33c7c181f771c0107c47072dc798ccc9ebc05d1959d39c84da734034d1a"
    sha256 arm64_monterey: "7e76d58caeacc55e79d58a9daded5f6262832011fbb96b0c37e0c8cf9f4a2b28"
    sha256 arm64_big_sur:  "8367df08c12c6599732eadf90005caa0811b3f302267600ff991fc58075080f5"
    sha256 ventura:        "2ee42119fb5232f867ac2472f7054afda31b1bbc5d72909a43fd3e3935908839"
    sha256 monterey:       "05be2243b1dc4d19ecd8fd342b2585d200d13419fd3ecdf9d311ab8098c96d7a"
    sha256 big_sur:        "bf6ab39a45e0d9392f927c8fd935f94968edbf7be1385afb1ab44d4cac3bc5d9"
    sha256 x86_64_linux:   "acc12b445557a8b4c5872e7fae4653e36ccc74b618c9bd82eb40f28c7618e0b6"
  end

  keg_only :provided_by_macos

  depends_on "openssl@3"

  on_linux do
    depends_on "util-linux"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-accesslog
      --enable-auditlog
      --enable-bdb=no
      --enable-constraint
      --enable-dds
      --enable-deref
      --enable-dyngroup
      --enable-dynlist
      --enable-hdb=no
      --enable-memberof
      --enable-ppolicy
      --enable-proxycache
      --enable-refint
      --enable-retcode
      --enable-seqmod
      --enable-translucent
      --enable-unique
      --enable-valsort
      --without-systemd
    ]

    if OS.linux? || MacOS.version >= :ventura
      # Disable manpage generation, because it requires groff which has a huge
      # dependency tree on Linux and isn't included on macOS since Ventura.
      inreplace "Makefile.in" do |s|
        subdirs = s.get_make_var("SUBDIRS").split - ["doc"]
        s.change_make_var! "SUBDIRS", subdirs.join(" ")
      end
    end

    system "./configure", *args
    system "make", "install"
    (var/"run").mkpath

    # https://github.com/Homebrew/homebrew-dupes/pull/452
    chmod 0755, etc.glob("openldap/*")
    chmod 0755, etc.glob("openldap/schema/*")

    # Don't embed Cellar references in files installed in `etc`.
    # Passing `build.bottle?` ensures that inreplace failures result in build failures
    # only when building a bottle. This helps avoid problems for users who build from source
    # and may have an old version of these files in `etc`.
    inreplace etc.glob("openldap/slapd.{conf,ldif}"), prefix, opt_prefix, build.bottle?
  end

  test do
    system sbin/"slappasswd", "-s", "test"
  end
end
