class Libksba < Formula
  desc "X.509 and CMS library"
  homepage "https://www.gnupg.org/related_software/libksba/"
  url "https://gnupg.org/ftp/gcrypt/libksba/libksba-1.6.4.tar.bz2"
  sha256 "bbb43f032b9164d86c781ffe42213a83bf4f2fee91455edfa4654521b8b03b6b"
  license any_of: ["LGPL-3.0-or-later", "GPL-2.0-or-later"]

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/libksba/"
    regex(/href=.*?libksba[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "11cc7eef7505b34197d25b269ed3667c3f4f1a48c67a0768b948d00c5b5b4538"
    sha256 cellar: :any,                 arm64_monterey: "8cbf05f9897a582dc8daf0ddc08a4e319733c82807c055be0ebf7f01b2aad032"
    sha256 cellar: :any,                 arm64_big_sur:  "76f3aae65a1bbacf9db92d95f542fdf28ca7076e131bfa2888657500978364e6"
    sha256 cellar: :any,                 ventura:        "13c075296da27e756b10ae1819cf56cac003ed22a986a2daa535d78cf7951d71"
    sha256 cellar: :any,                 monterey:       "176cd879bcefc75067d53a240a3f4689121ee6dfd0b0d645f6d95422db668a9e"
    sha256 cellar: :any,                 big_sur:        "a61c04ac7299c87513f8b773de5e79e04f4cc9d7d1ba9d156ed38bd5f11b7afd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f544c8f18b174da592f4d40040cadd68d39d438fb53dc39c9d7c4f5a0dbd1567"
  end

  depends_on "libgpg-error"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace bin/"ksba-config", prefix, opt_prefix
  end

  test do
    system "#{bin}/ksba-config", "--libs"
  end
end
