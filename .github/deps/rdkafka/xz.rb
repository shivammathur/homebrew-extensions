# Upstream project has requested we use a mirror as the main URL
# https://github.com/Homebrew/legacy-homebrew/pull/21419
class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  # The archive.org mirror below needs to be manually created at `archive.org`.
  url "https://downloads.sourceforge.net/project/lzmautils/xz-5.4.1.tar.gz"
  mirror "https://tukaani.org/xz/xz-5.4.1.tar.gz"
  mirror "https://archive.org/download/xz-5.4.1/xz-5.4.1.tar.gz"
  mirror "http://archive.org/download/xz-5.4.1/xz-5.4.1.tar.gz"
  sha256 "e4b0f81582efa155ccf27bb88275254a429d44968e488fc94b806f2a61cd3e22"
  license all_of: [
    :public_domain,
    "LGPL-2.1-or-later",
    "GPL-2.0-or-later",
    "GPL-3.0-or-later",
  ]

  bottle do
    sha256 cellar: :any, arm64_ventura:  "26ede511c3cc726f939dd2f61b7e6798409c86b62be4678f008a12d515584efb"
    sha256 cellar: :any, arm64_monterey: "3908f1a9e36d68a9707718296725765885b813ee31f315e43825a2c8f2ccb33a"
    sha256 cellar: :any, arm64_big_sur:  "80b60695eb50d9605a21dfe99db4096ae728c1d9409c532403c0accb50a98638"
    sha256 cellar: :any, ventura:        "619b87932c5393af72b259b17ee8270275e0e5dc8893bdae2bf08fbebdc10211"
    sha256 cellar: :any, monterey:       "a3c40525ab04986a06dc672be4912207c55363298aeb9a7e32375007b8f6c5df"
    sha256 cellar: :any, big_sur:        "55e32fb63afac31a9d21bef5e8e310f2ca0629f055d1a72cb5f14d7afa2fc0e7"
    sha256               x86_64_linux:   "a2e27545d92f5387a48182319b5233a42c9ce98bea335fc4cdf15c808ab1ea1b"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
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
  end
end
