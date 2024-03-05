class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://xz.tukaani.org/xz-utils/"
  # The archive.org mirror below needs to be manually created at `archive.org`.
  url "https://github.com/tukaani-project/xz/releases/download/v5.6.0/xz-5.6.0.tar.gz"
  mirror "https://downloads.sourceforge.net/project/lzmautils/xz-5.6.0.tar.gz"
  mirror "https://archive.org/download/xz-5.6.0/xz-5.6.0.tar.gz"
  mirror "http://archive.org/download/xz-5.6.0/xz-5.6.0.tar.gz"
  sha256 "0f5c81f14171b74fcc9777d302304d964e63ffc2d7b634ef023a7249d9b5d875"
  license all_of: [
    "0BSD",
    "LGPL-2.1-or-later",
    "GPL-2.0-or-later",
    "GPL-3.0-or-later",
  ]

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "6dd426cf064ecc9ef5b832c81a307816efa1a8572964f126da173a5473c387ac"
    sha256 cellar: :any,                 arm64_ventura:  "5a9febbc79a323d44320d1a73625a1a08ac9569ebe8d66a02221a2b40f4f1dc4"
    sha256 cellar: :any,                 arm64_monterey: "dbde826e506ca336a9c37fb2cc499832338c898594942659c50ed37f8e99b53d"
    sha256 cellar: :any,                 sonoma:         "1a24ab5c033d33089fc23fa581b112a6b72c8c72452fe20553c9416aeb08bc08"
    sha256 cellar: :any,                 ventura:        "870358edf67be67c392141cc6cfd405a7469c705e99b19abec4d71e83357f334"
    sha256 cellar: :any,                 monterey:       "4d0571f3f5fc7e165d3b125c78e0f76b94ab5c6a35bc7d6013e23b3ddd667e66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5828e7adadf0ed4d0cc68c487b6f132355e3e81561500c64fb62a0eb68b5cba3"
  end

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
    refute_predicate path, :exist?

    # decompress: data.txt.xz -> data.txt
    system bin/"xz", "-d", "#{path}.xz"
    assert_equal original_contents, path.read

    # Check that http mirror works
    xz_tar = testpath/"xz.tar.gz"
    stable.mirrors.each do |mirror|
      next if mirror.start_with?("https")

      xz_tar.unlink if xz_tar.exist?
      system "curl", "--location", mirror, "--output", xz_tar
      assert_equal stable.checksum.hexdigest, xz_tar.sha256
    end
  end
end
