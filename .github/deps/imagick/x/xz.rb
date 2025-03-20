class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  url "https://github.com/tukaani-project/xz/releases/download/v5.6.4/xz-5.6.4.tar.gz"
  mirror "https://downloads.sourceforge.net/project/lzmautils/xz-5.6.4.tar.gz"
  mirror "http://downloads.sourceforge.net/project/lzmautils/xz-5.6.4.tar.gz"
  sha256 "269e3f2e512cbd3314849982014dc199a7b2148cf5c91cedc6db629acdf5e09b"
  license all_of: [
    "0BSD",
    "GPL-2.0-or-later",
  ]
  version_scheme 1

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "51c0ca6cfcb507fa9b45136c49d204316a387671753f2b8de1392461b18a44ba"
    sha256 cellar: :any,                 arm64_sonoma:  "6206718ef4a56b67651a96d220688deada5727ac67e5e9c23012acc99e0bc4a8"
    sha256 cellar: :any,                 arm64_ventura: "1693b66ae6c6f48618443bd9d512d06f2ec5681970b2a168484d99a9cd2bc2d6"
    sha256 cellar: :any,                 sequoia:       "e26b9b870c54ffc8ef21503ce0209265e23dbf2f89ea5b539d463169426b0b33"
    sha256 cellar: :any,                 sonoma:        "887964ef0fbc415c0d96288072f2d5dc62800b3c10c177b673c7136b51830a9b"
    sha256 cellar: :any,                 ventura:       "6d366675f1db2034ed30fa9cb2edebf7ca8c52a5ef5e067bff5394ca7b1514b1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2e84ab04b837b01fc24f489cbb90731911840f37df55df2938c90200fa24d5b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d26feb517c927f362970b7aead6b0e7756119a0ebfd1ed1201a7fa193fa96b18"
  end

  deny_network_access! [:build, :postinstall]

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules", "--disable-nls"
    system "make", "check"
    system "make", "install"
  end

  test do
    path = testpath/"data.txt"
    original_contents = "." * 1000
    path.write original_contents

    # compress: data.txt -> data.txt.xz
    system bin/"xz", path
    refute_path_exists path

    # decompress: data.txt.xz -> data.txt
    system bin/"xz", "-d", "#{path}.xz"
    assert_equal original_contents, path.read

    # Check that http mirror works
    xz_tar = testpath/"xz.tar.gz"
    stable.mirrors.each do |mirror|
      next if mirror.start_with?("https")

      xz_tar.unlink if xz_tar.exist?

      # Set fake CA Cert to block any HTTPS redirects.
      system "curl", "--location", mirror, "--cacert", "/fake", "--output", xz_tar
      assert_equal stable.checksum.hexdigest, xz_tar.sha256
    end
  end
end
