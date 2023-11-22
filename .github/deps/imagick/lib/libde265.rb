class Libde265 < Formula
  desc "Open h.265 video codec implementation"
  homepage "https://github.com/strukturag/libde265"
  url "https://github.com/strukturag/libde265/releases/download/v1.0.14/libde265-1.0.14.tar.gz"
  sha256 "99f46ef77a438be639aa3c5d9632c0670541c5ed5d386524d4199da2d30df28f"
  license "LGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "0be0b7a8497e2ec179a5ea96e0a7dc937df207f1ab488d5d0009ecc082597805"
    sha256 cellar: :any,                 arm64_ventura:  "9581131acf8b1bd6b123f69b6494b9e3150c2cd302679d899579f408890d4b89"
    sha256 cellar: :any,                 arm64_monterey: "1fe16ef408afbbc745f5fa2d35fbcc7b5edb68f54eddf9a1af61b0a90a88d0ac"
    sha256 cellar: :any,                 sonoma:         "2ee68e781f874848e837e48d9267d132dd0f3ddeeb78b9a1fc466bd4f6441daf"
    sha256 cellar: :any,                 ventura:        "477a583831cd2501c600da500b693540c467b07462a8d97fd45d60217c3e476e"
    sha256 cellar: :any,                 monterey:       "814434a887fe79aa142c5cc994d381e5dc0f298d2655a917cc6133b455080265"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3933957dd1903a9418a71bc7d0a25b166ea8f8b7716cb58ff97242de5483a5f1"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    extra_args = []
    extra_args << "--build=aarch64-apple-darwin#{OS.kernel_version}" if OS.mac? && Hardware::CPU.arm?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-sherlock265",
                          "--disable-dec265",
                          "--prefix=#{prefix}",
                          *extra_args
    system "make", "install"

    # Install the test-related executables in libexec.
    (libexec/"bin").install bin/"acceleration_speed",
                            bin/"block-rate-estim",
                            bin/"tests"
  end

  test do
    system libexec/"bin/tests"
  end
end
