class Libarchive < Formula
  desc "Multi-format archive and compression library"
  homepage "https://www.libarchive.org"
  url "https://www.libarchive.org/downloads/libarchive-3.7.5.tar.xz"
  sha256 "ca74ff8f99dd40ab8a8274424d10a12a7ec3f4428dd35aee9fdda8bdb861b570"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?libarchive[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "9cb5ec8dab474f5f3c9806d2cd825973844dc94886b8d15f7599dc68c8b9afb4"
    sha256 cellar: :any,                 arm64_sonoma:  "e2d6daab00b8510a66936facd997fdedf5b2ff618b24462e9e106af1f4a11251"
    sha256 cellar: :any,                 arm64_ventura: "222418a2a772611e7a5fe37a4fe90a949290011b43b8c1eaf1b44a5a7c29f854"
    sha256 cellar: :any,                 sonoma:        "57374766f23272fce9ed96e90d9e0e0b5a41e90950835d2b137e1cdc84b086e8"
    sha256 cellar: :any,                 ventura:       "29c490cbe4dc1622b9ef1152316682a87721f26c0559be7f3f022af6e3bef44c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fb8fc9bc98277fdad224acae0d1bda1a3eca00c9a03ef846549f768bbe81af7"
  end

  keg_only :provided_by_macos

  depends_on "libb2"
  depends_on "lz4"
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "bzip2"
  uses_from_macos "expat"
  uses_from_macos "zlib"

  def install
    system "./configure", *std_configure_args,
           "--without-lzo2",    # Use lzop binary instead of lzo2 due to GPL
           "--without-nettle",  # xar hashing option but GPLv3
           "--without-xml2",    # xar hashing option but tricky dependencies
           "--without-openssl", # mtree hashing now possible without OpenSSL
           "--with-expat"       # best xar hashing option

    system "make", "install"

    # fixes https://github.com/libarchive/libarchive/issues/1819
    if OS.mac?
      inreplace lib/"pkgconfig/libarchive.pc", "Libs.private: ", "Libs.private: -liconv "
      inreplace lib/"pkgconfig/libarchive.pc", "Requires.private: iconv", ""
    end

    return unless OS.mac?

    # Just as apple does it.
    ln_s bin/"bsdtar", bin/"tar"
    ln_s bin/"bsdcpio", bin/"cpio"
    ln_s man1/"bsdtar.1", man1/"tar.1"
    ln_s man1/"bsdcpio.1", man1/"cpio.1"
  end

  test do
    (testpath/"test").write("test")
    system bin/"bsdtar", "-czvf", "test.tar.gz", "test"
    assert_match "test", shell_output("#{bin}/bsdtar -xOzf test.tar.gz")
  end
end
