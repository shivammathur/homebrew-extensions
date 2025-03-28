class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  url "https://github.com/tukaani-project/xz/releases/download/v5.8.0/xz-5.8.0.tar.gz"
  mirror "https://downloads.sourceforge.net/project/lzmautils/xz-5.8.0.tar.gz"
  mirror "http://downloads.sourceforge.net/project/lzmautils/xz-5.8.0.tar.gz"
  sha256 "b523c5e47d1490338c5121bdf2a6ecca2bcf0dce05a83ad40a830029cbe6679b"
  license all_of: [
    "0BSD",
    "GPL-2.0-or-later",
  ]
  version_scheme 1

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "35317170a7dae8a32dfff36742214f14a3975b08fbdd4b1ca35e416cea3101c9"
    sha256 cellar: :any,                 arm64_sonoma:  "64c6f868fca6d8dc47fcfec0aa9e8de45f19cbe3bcdb583a9713fc3b13e8f21d"
    sha256 cellar: :any,                 arm64_ventura: "da291260af0e11aea972ac1c2cc23cf1385f24402d603a845b6e51d4f07eb947"
    sha256 cellar: :any,                 sequoia:       "1d0c4c1288e3ed0cfb2093db85e445872df5875da1a3828e05f5a58759dcbb80"
    sha256 cellar: :any,                 sonoma:        "51d4a6c836d9739937f654e6ddbac112ce2bc64b0a45f947d06aa6648b99a055"
    sha256 cellar: :any,                 ventura:       "d800b4940567d1d2b592a8aef55cdcc796457886c81e044f1b76ffebb9d54a45"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "719299c4009ed3f1b7d0991a40ef9a494434c705b11df18ad0f486029d496cc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10b677c3398e813242c977e69d0a13a0943406aa36ef8eb5074da9d4453e909e"
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
