class Pmix < Formula
  desc "Process Management Interface for HPC environments"
  homepage "https://openpmix.github.io/"
  license "BSD-3-Clause"

  stable do
    url "https://github.com/openpmix/openpmix/releases/download/v5.0.4/pmix-5.0.4.tar.bz2"
    sha256 "f72d50a5ae9315751684ade8a8e9ac141ae5dd64a8652d594b9bee3531a91376"

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
    sha256 arm64_sequoia: "33a8383ee6db511465db7a341d2faf6bbe8d7cff73dc5e0697068b3692ee84df"
    sha256 arm64_sonoma:  "8f2a87771982fc2c5dfe6857ccafd0841185bf2f2d46479d10e02c376edd7498"
    sha256 arm64_ventura: "5174b666629a26e3e658a8401ff2bd4dc784bcec4b76efb67234064fcac7a7a5"
    sha256 sonoma:        "e2fd27c1640f81c466c4f1fd99ebf71d1f428cc36820ee7c3db412bc8d734470"
    sha256 ventura:       "8702bec70abdbc6af2c94b86cfe19ea0c4ad9add399adc4cccbcf90a099a6ec6"
    sha256 x86_64_linux:  "cb73e8a90edd9604c85130a04e8e150d0ddbac290bb75c7151940a83b594e320"
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
