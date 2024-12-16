class Pmix < Formula
  desc "Process Management Interface for HPC environments"
  homepage "https://openpmix.github.io/"
  license "BSD-3-Clause"

  stable do
    url "https://github.com/openpmix/openpmix/releases/download/v5.0.5/pmix-5.0.5.tar.bz2"
    sha256 "a12e148c8ec4b032593a2c465a762e93c43ad715f3ceb9fbc038525613b0c70d"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_sequoia: "aa8d3800fdcc79fad479a431e304d5bda425a0d280ff4b6f122583f2ec25c142"
    sha256 arm64_sonoma:  "560cd6420113aed6f2d099fcf806cc4d87d3b531a6e2860998f8ae1f4980e615"
    sha256 arm64_ventura: "db2a331eeb1822b36667ad66f7559ed4185ff665d47492020864d68a8a2c6d77"
    sha256 sonoma:        "d93a21ec141dab7d214157db3bacbaa5e51d3f6236e462c3c3717f66203f97f1"
    sha256 ventura:       "62812873f092e08036885e88c93f733cccf727e59993902ed12217aa225b60ea"
    sha256 x86_64_linux:  "3a5ad6e788077ac5f7113c0d974dfabf8eeacf76181923988f5f7a73d47506d6"
  end

  head do
    url "https://github.com/openpmix/openpmix.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "hwloc"
  depends_on "libevent"

  uses_from_macos "python" => :build
  uses_from_macos "zlib"

  def install
    # Avoid references to the Homebrew shims directory
    cc = OS.linux? ? "gcc" : ENV.cc
    inreplace "src/tools/pmix_info/support.c", "PMIX_CC_ABSOLUTE", "\"#{cc}\""

    args = %W[
      --disable-silent-rules
      --enable-ipv6
      --sysconfdir=#{etc}
      --with-hwloc=#{Formula["hwloc"].opt_prefix}
      --with-libevent=#{Formula["libevent"].opt_prefix}
      --with-sge
    ]

    system "./autogen.pl", "--force" if build.head?
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <pmix.h>

      int main(int argc, char **argv) {
        pmix_value_t *val;
        pmix_proc_t myproc;
        pmix_status_t rc;

        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lpmix", "-o", "test"
    system "./test"

    assert_match "PMIX: #{version}", shell_output("#{bin}/pmix_info --pretty-print")
  end
end
