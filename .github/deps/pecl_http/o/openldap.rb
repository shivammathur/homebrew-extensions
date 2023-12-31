class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "https://www.openldap.org/software/"
  url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.6.tgz"
  mirror "http://fresh-center.net/linux/misc/openldap-2.6.6.tgz"
  mirror "http://fresh-center.net/linux/misc/legacy/openldap-2.6.6.tgz"
  sha256 "082e998cf542984d43634442dbe11da860759e510907152ea579bdc42fe39ea0"
  license "OLDAP-2.8"

  livecheck do
    url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/"
    regex(/href=.*?openldap[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 arm64_sonoma:   "fab501c48e2f9e64bbf906ff017ca61f432555425135d16ebd0c69c0de2b6b2b"
    sha256 arm64_ventura:  "3225031ce7d791f4a83eaf1acc44c5e5f1dc6da7abe9882f4c4b06b6fa2c7a58"
    sha256 arm64_monterey: "6af7058f3fa120b38b6a3fe203569a0f9c2ec0696bebc21c8b1ff310793d0371"
    sha256 sonoma:         "534ee0d0dc9cd6fa1658a6ca14ebf7e11bdca8fb4d765823f0441a3d667a1828"
    sha256 ventura:        "bf5b152fc307a19c274a527403d74eb03428dc0a184ff5f2b28301e8fbabfeb4"
    sha256 monterey:       "64744bbdd854d2716f1a8ed694b9f9b4b4d95650c7bf007b387a28a5239634bd"
    sha256 x86_64_linux:   "167e6a9b406c74a9d805aff8b97f5873fcb91396b4ba10980370ab03472f6950"
  end

  keg_only :provided_by_macos

  depends_on "openssl@3"

  uses_from_macos "mandoc" => :build

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

    soelim = if OS.mac?
      if MacOS.version >= :ventura
        "mandoc_soelim"
      else
        "soelim"
      end
    else
      "bsdsoelim"
    end

    system "./configure", *args
    system "make", "install", "SOELIM=#{soelim}"
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
