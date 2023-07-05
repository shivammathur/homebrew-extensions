class Gnupg < Formula
  desc "GNU Pretty Good Privacy (PGP) package"
  homepage "https://gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.3.tar.bz2"
  sha256 "a271ae6d732f6f4d80c258ad9ee88dd9c94c8fdc33c3e45328c4d7c126bd219d"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gnupg/"
    regex(/href=.*?gnupg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_ventura:  "5476d2eb89c8e8ac94c4b2bb9580fd4cafdad679acc4cdb98eea3bd19f63c6f9"
    sha256 arm64_monterey: "f470a33d376cc0604664ca66fa0dc3f02876e352dd2078bf9f6e42d9b61f90bd"
    sha256 arm64_big_sur:  "d9add1a61c6ea39c6fb9a93896ff294ecb7847b3a8951a45c2bf603e30434c85"
    sha256 ventura:        "e8e6200a68d30f6f82504cdb1dfa9e4e7df434a72cd8c8f3e10f7658936b0ef7"
    sha256 monterey:       "5c0a3ece0457155bd12a5f74ea4a8851a30ea7531e56910efa224f02adaaeadc"
    sha256 big_sur:        "ce39f26cd950ea12436a369936baf5833d770fd0d38caf731e619d578a8eeb03"
    sha256 x86_64_linux:   "a463bb762bdc256fd715725ec287083a9b3c834f9e46ccf47fd0937b0e042e1c"
  end

  depends_on "pkg-config" => :build
  depends_on "gnutls"
  depends_on "libassuan"
  depends_on "libgcrypt"
  depends_on "libgpg-error"
  depends_on "libksba"
  depends_on "libusb"
  depends_on "npth"
  depends_on "pinentry"
  depends_on "readline"

  uses_from_macos "bzip2"
  uses_from_macos "openldap"
  uses_from_macos "sqlite", since: :catalina
  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
  end

  def install
    libusb = Formula["libusb"]
    ENV.append "CPPFLAGS", "-I#{libusb.opt_include}/libusb-#{libusb.version.major_minor}"

    mkdir "build" do
      system "../configure", *std_configure_args,
                             "--disable-silent-rules",
                             "--sysconfdir=#{etc}",
                             "--enable-all-tests",
                             "--with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry"
      system "make"
      system "make", "check"
      system "make", "install"
    end

    # Configure scdaemon as recommended by upstream developers
    # https://dev.gnupg.org/T5415#145864
    if OS.mac?
      # write to buildpath then install to ensure existing files are not clobbered
      (buildpath/"scdaemon.conf").write <<~EOS
        disable-ccid
      EOS
      pkgetc.install "scdaemon.conf"
    end
  end

  def post_install
    (var/"run").mkpath
    quiet_system "killall", "gpg-agent"
  end

  test do
    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      (testpath/"test.txt").write "Hello World!"
      system bin/"gpg", "--detach-sign", "test.txt"
      system bin/"gpg", "--verify", "test.txt.sig"
    ensure
      system bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
