class Hwloc < Formula
  desc "Portable abstraction of the hierarchical topology of modern architectures"
  homepage "https://www.open-mpi.org/projects/hwloc/"
  url "https://download.open-mpi.org/release/hwloc/v2.9/hwloc-2.9.0.tar.bz2"
  sha256 "2070e963596a2421b9af8eca43bdec113ee1107aaf7ccb475d4d3767a8856887"
  license "BSD-3-Clause"

  livecheck do
    url "https://www.mail-archive.com/hwloc-announce@lists.open-mpi.org/"
    regex(/[\s,>]v?(\d+(?:\.\d+)+)(?:\s*?,|\s*?released)/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "ebc0569119f947e8fb8d7fe6afd16c0837b4cea63bdf3da4aa6780a34b602255"
    sha256 cellar: :any,                 arm64_monterey: "b21514e88d48aaa2337f885d20ec652518de6592e9e2e31d02f9f77b40ca8d21"
    sha256 cellar: :any,                 arm64_big_sur:  "44f5c7c1fa40a2e92547848f94bf8b5d3342c332440c17c924a2d723bb99c265"
    sha256 cellar: :any,                 ventura:        "f5177bb1cee6726d0ce1f5e38f1565cc6ef57bc7d012ecd171142ebc6b383d43"
    sha256 cellar: :any,                 monterey:       "5f7e91070d53048025f859c7818061bf45f439e905a651de6f4797e7a67fcc3e"
    sha256 cellar: :any,                 big_sur:        "72763e5ea7bc83e12e27b2ba45e00d2bbd7275f8f78192037b0e3c70a7b22e68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "823f01a9103475e97c90b55256380d4b12e662c6282b379b842edc4908dd340b"
  end

  head do
    url "https://github.com/open-mpi/hwloc.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build

  uses_from_macos "libxml2"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", *std_configure_args,
                          "--enable-shared",
                          "--enable-static",
                          "--disable-cairo",
                          "--without-x"
    system "make", "install", "bashcompletionsdir=#{bash_completion}"

    pkgshare.install "tests"

    # remove homebrew shims directory references
    rm Dir[pkgshare/"tests/**/Makefile"]
  end

  test do
    system ENV.cc, pkgshare/"tests/hwloc/hwloc_groups.c", "-I#{include}",
                   "-L#{lib}", "-lhwloc", "-o", "test"
    system "./test"
  end
end
