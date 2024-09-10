class Boost < Formula
  desc "Collection of portable C++ source libraries"
  homepage "https://www.boost.org/"
  license "BSL-1.0"
  head "https://github.com/boostorg/boost.git", branch: "master"

  stable do
    url "https://github.com/boostorg/boost/releases/download/boost-1.86.0/boost-1.86.0-b2-nodocs.tar.xz"
    sha256 "a4d99d032ab74c9c5e76eddcecc4489134282245fffa7e079c5804b92b45f51d"

    # Backport Boost.Compute support for latest Boost.Uuid
    patch :p2 do
      url "https://github.com/boostorg/compute/commit/79452d5279831ee59a650c17b71259a821f1a554.patch?full_index=1"
      sha256 "ed4b9740c1f300ed0413498f0cba6f05389b570bec6a4b456d53314a2561d061"
    end
    patch :p2 do
      url "https://github.com/boostorg/compute/commit/54915acaafa003b7aab6f24c74e7fdeaae297ad6.patch?full_index=1"
      sha256 "1d1e83f4cb371003bad84a3789b2fecf215768f4a6f933444eaa4c26905f1e9f"
    end
  end

  livecheck do
    url "https://www.boost.org/users/download/"
    regex(/href=.*?boost[._-]v?(\d+(?:[._]\d+)+)\.t/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match.first.tr("_", ".") }
    end
  end

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "c05f399132e5fdca2e010ba1d9af155e956a8ed70dcfd57aa285a772efac3efa"
    sha256 cellar: :any,                 arm64_sonoma:   "8f6d3d3c76708a287c0157a0e48f0e2b8c7175ee23269c03c8eb0ad7c003dc86"
    sha256 cellar: :any,                 arm64_ventura:  "7eb491c2e34ff445b92883bba4483f085c35eeb40cc6f021636d09c9fc3b7b25"
    sha256 cellar: :any,                 arm64_monterey: "e1942964bba4803b5c01bf1b69f1fa15908e4f1372732f7bf2edb5fa1be54a75"
    sha256 cellar: :any,                 sonoma:         "eb5a1eab5cfa550707a4e2148451c9a9c2b0ecdd2b7a4f4cf786cc830055e80c"
    sha256 cellar: :any,                 ventura:        "f40318ac4b779df9fbb13bed9166a39eb9819438fe8b9c4b764cca973f739295"
    sha256 cellar: :any,                 monterey:       "bd5f3394381a43315858c033adfbc430ead8e53d607686efef760637fe77298f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b54de744fca5203371e41bbe08f18fe347d9873558b9b0e1c40b60e4bc5515c"
  end

  depends_on "icu4c"
  depends_on "xz"
  depends_on "zstd"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    # Force boost to compile with the desired compiler
    open("user-config.jam", "a") do |file|
      if OS.mac?
        file.write "using darwin : : #{ENV.cxx} ;\n"
      else
        file.write "using gcc : : #{ENV.cxx} ;\n"
      end
    end

    # libdir should be set by --prefix but isn't
    icu4c_prefix = Formula["icu4c"].opt_prefix
    bootstrap_args = %W[
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-icu=#{icu4c_prefix}
    ]

    # Handle libraries that will not be built.
    without_libraries = ["python", "mpi"]

    # Boost.Log cannot be built using Apple GCC at the moment. Disabled
    # on such systems.
    without_libraries << "log" if ENV.compiler == :gcc

    bootstrap_args << "--without-libraries=#{without_libraries.join(",")}"

    # layout should be synchronized with boost-python and boost-mpi
    args = %W[
      --prefix=#{prefix}
      --libdir=#{lib}
      -d2
      -j#{ENV.make_jobs}
      --layout=tagged-1.66
      --user-config=user-config.jam
      install
      threading=multi,single
      link=shared,static
    ]

    # Boost is using "clang++ -x c" to select C compiler which breaks C++14
    # handling using ENV.cxx14. Using "cxxflags" and "linkflags" still works.
    args << "cxxflags=-std=c++14"
    args << "cxxflags=-stdlib=libc++" << "linkflags=-stdlib=libc++" if ENV.compiler == :clang

    system "./bootstrap.sh", *bootstrap_args
    system "./b2", "headers"
    system "./b2", *args
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <boost/algorithm/string.hpp>
      #include <boost/iostreams/device/array.hpp>
      #include <boost/iostreams/device/back_inserter.hpp>
      #include <boost/iostreams/filter/zstd.hpp>
      #include <boost/iostreams/filtering_stream.hpp>
      #include <boost/iostreams/stream.hpp>

      #include <string>
      #include <iostream>
      #include <vector>
      #include <assert.h>

      using namespace boost::algorithm;
      using namespace boost::iostreams;
      using namespace std;

      int main()
      {
        string str("a,b");
        vector<string> strVec;
        split(strVec, str, is_any_of(","));
        assert(strVec.size()==2);
        assert(strVec[0]=="a");
        assert(strVec[1]=="b");

        // Test boost::iostreams::zstd_compressor() linking
        std::vector<char> v;
        back_insert_device<std::vector<char>> snk{v};
        filtering_ostream os;
        os.push(zstd_compressor());
        os.push(snk);
        os << "Boost" << std::flush;
        os.pop();

        array_source src{v.data(), v.size()};
        filtering_istream is;
        is.push(zstd_decompressor());
        is.push(src);
        std::string s;
        is >> s;

        assert(s == "Boost");

        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++14", "-o", "test", "-L#{lib}", "-lboost_iostreams",
                    "-L#{Formula["zstd"].opt_lib}", "-lzstd"
    system "./test"
  end
end
