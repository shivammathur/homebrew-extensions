class Libarchive < Formula
  desc "Multi-format archive and compression library"
  homepage "https://www.libarchive.org"
  url "https://www.libarchive.org/downloads/libarchive-3.7.2.tar.xz"
  sha256 "04357661e6717b6941682cde02ad741ae4819c67a260593dfb2431861b251acb"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?libarchive[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "2c45dd86e312dbb9d4a376deb349815e23e102b0d9a889f554f4134bd0984d03"
    sha256 cellar: :any,                 arm64_ventura:  "cd373f7974f63688a43425bf4de15bd82076b63a59dc5301e4ea68e61bd703cd"
    sha256 cellar: :any,                 arm64_monterey: "1c491d1f364304c2aab8f5ca16250b46d8282c14ccd33e400738dcdf2895515e"
    sha256 cellar: :any,                 sonoma:         "c976c412e5ac051844ea4155b8c4ef93f573a4a344001b70183da335703ce465"
    sha256 cellar: :any,                 ventura:        "d1fcdd29b04917e58691928d09fa18909ef4299983fea4a01371568ba9adbdff"
    sha256 cellar: :any,                 monterey:       "006e92ee1e3650794f5cb17c73f6d4fda4c12786ab2f943df2431a5096bda53b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8143854ccb005b432e66bdc53e80c47692332d0446dbfd0d9a24d9366ac5ceb0"
  end

  keg_only :provided_by_macos

  depends_on "libb2"
  depends_on "lz4"
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "bzip2"
  uses_from_macos "expat"
  uses_from_macos "zlib"

  # Safer handling of error reporting.
  # Will be a part of the next release.
  patch do
    url "https://github.com/libarchive/libarchive/commit/6110e9c82d8ba830c3440f36b990483ceaaea52c.patch?full_index=1"
    sha256 "34c11e1b9101919a94ffec7012a74190ee1ac05e23a68778083695fc2e66e502"
  end

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
