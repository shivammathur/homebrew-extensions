class Hwloc < Formula
  desc "Portable abstraction of the hierarchical topology of modern architectures"
  homepage "https://www.open-mpi.org/projects/hwloc/"
  url "https://download.open-mpi.org/release/hwloc/v2.9/hwloc-2.9.3.tar.bz2"
  sha256 "5c4062ce556f6d3451fc177ffb8673a2120f81df6835dea6a21a90fbdfff0dec"
  license "BSD-3-Clause"

  livecheck do
    url "https://www.open-mpi.org/software/hwloc/current/downloads/latest_release.txt"
    regex(/(\d+\.\d+\.\d+)/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "3abcf3913a81ebf755bbda7a2e5f59c3e53078fb6cf35264d83e9d9da3ceebb1"
    sha256 cellar: :any,                 arm64_ventura:  "eff0a2f159a749587cfb4e6d3da8f3cd057591310325821d07f651ea0ecca25a"
    sha256 cellar: :any,                 arm64_monterey: "7991e59cba29f3e69ee87147400f2d283245f89efb65511f3b7fbae72bf1568b"
    sha256 cellar: :any,                 sonoma:         "64fabf356c3b9871a9701851c9dffc30a4f3ca3bc5819111f4f2258957fecdfd"
    sha256 cellar: :any,                 ventura:        "16a715cd3cdde0d6750cc935e6a5c5d2185b24c6ec0315c6acf5326daa87f3ef"
    sha256 cellar: :any,                 monterey:       "8cfe9f6649200e089460520a32d6a947418a0dc6376eb9f4597c95bda0a73723"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad2937bea62c3e0371cf3a120c95d04f54edaac40869befae34841077c16fb58"
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
