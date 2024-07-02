class Hwloc < Formula
  desc "Portable abstraction of the hierarchical topology of modern architectures"
  homepage "https://www.open-mpi.org/projects/hwloc/"
  url "https://download.open-mpi.org/release/hwloc/v2.11/hwloc-2.11.0.tar.bz2"
  sha256 "03903b87cad5db72bd00f7926d6a53744b10c5c6a238c6b68510e7dc1560e4f9"
  license "BSD-3-Clause"

  livecheck do
    url "https://www.open-mpi.org/software/hwloc/current/downloads/latest_release.txt"
    regex(/(\d+\.\d+\.\d+)/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "82bd05d6b04a01854c9a3601a21405673951b57485c61ed61f21c851dfbd52bd"
    sha256 cellar: :any,                 arm64_ventura:  "b3c48332505261821ba1f2c4b7ad0b0f83a243f68ac973e317315c2fb9bb1441"
    sha256 cellar: :any,                 arm64_monterey: "c209599a54a7a3c56ec72880d71fefed4c28d4bc7b118eb59a0b4311edea5890"
    sha256 cellar: :any,                 sonoma:         "7e166a0ef235e401f02fa59e55fa61f31fd6caa206085b8aa6249eb0bf6ac9f6"
    sha256 cellar: :any,                 ventura:        "0a676c53ef17512fdebe5d9b23abdaaaae06202b989ea0f45962221e4ad312d6"
    sha256 cellar: :any,                 monterey:       "f66cac578955754c0f2ae9048e0029329a1a68daa0825e15923f9392aeae6184"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a9781058a82bec16e2d9138343dbc66a630e1c2937160926fea3b611f7085f7"
  end

  head do
    url "https://github.com/open-mpi/hwloc.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

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
