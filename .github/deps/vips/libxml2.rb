class Libxml2 < Formula
  desc "GNOME XML library"
  homepage "http://xmlsoft.org/"
  url "https://download.gnome.org/sources/libxml2/2.11/libxml2-2.11.1.tar.xz"
  sha256 "3d39b294b856bfe3bafd5fb126e1f8487004261e78eabb8df9513e927915a995"
  license "MIT"

  # We use a common regex because libxml2 doesn't use GNOME's "even-numbered
  # minor is stable" version scheme.
  livecheck do
    url :stable
    regex(/libxml2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "8b1f6d12a5527688ee3a2d215e4b75ad02c10e9914fcf551b28817f175ba5c49"
    sha256 cellar: :any,                 arm64_monterey: "7ed5a466e76fc2ad0c85e8b2d4f5e2efa2d2667daca3d8e77a0801cc44fc2a81"
    sha256 cellar: :any,                 arm64_big_sur:  "030a34ca2ff30372b418925ee489e76fee65aff8f96c556d2d2e95213b43947f"
    sha256 cellar: :any,                 ventura:        "cdebcb74a854d3f6d52a9b5af852a6118052a4bb1fa481fc94b111de72a20abc"
    sha256 cellar: :any,                 monterey:       "0c84badcc01cd388cdc9f3483efcb9f4d28cce5f0eaef2de04af648d4c004411"
    sha256 cellar: :any,                 big_sur:        "27c9ff83bc4160afe3a14a19ed3fb5caf30fdc390ff67e25da05bef44e472a0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "439204eb8a35073f6c9abc5a8d09ce096f0a99bf96e3c2ecd749b76c8365fd96"
  end

  head do
    url "https://gitlab.gnome.org/GNOME/libxml2.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  keg_only :provided_by_macos

  depends_on "python@3.10" => [:build, :test]
  depends_on "python@3.11" => [:build, :test]
  depends_on "python@3.9" => [:build, :test]
  depends_on "pkg-config" => :test
  depends_on "icu4c"
  depends_on "readline"

  uses_from_macos "zlib"

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--with-history",
                          "--with-icu",
                          "--without-python",
                          "--without-lzma"
    system "make", "install"

    cd "python" do
      sdk_include = if OS.mac?
        sdk = MacOS.sdk_path_if_needed
        sdk/"usr/include" if sdk
      else
        HOMEBREW_PREFIX/"include"
      end

      includes = [include, sdk_include].compact.map do |inc|
        "'#{inc}',"
      end.join(" ")

      # We need to insert our include dir first
      inreplace "setup.py", "includes_dir = [",
                            "includes_dir = [#{includes}"

      pythons.each do |python|
        system python, *Language::Python.setup_install_args(prefix, python)
      end
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libxml/tree.h>

      int main()
      {
        xmlDocPtr doc = xmlNewDoc(BAD_CAST "1.0");
        xmlNodePtr root_node = xmlNewNode(NULL, BAD_CAST "root");
        xmlDocSetRootElement(doc, root_node);
        xmlFreeDoc(doc);
        return 0;
      }
    EOS

    # Test build with xml2-config
    args = shell_output("#{bin}/xml2-config --cflags --libs").split
    system ENV.cc, "test.c", "-o", "test", *args
    system "./test"

    # Test build with pkg-config
    ENV.append "PKG_CONFIG_PATH", lib/"pkgconfig"
    args = shell_output("#{Formula["pkg-config"].opt_bin}/pkg-config --cflags --libs libxml-2.0").split
    system ENV.cc, "test.c", "-o", "test", *args
    system "./test"

    pythons.each do |python|
      with_env(PYTHONPATH: prefix/Language::Python.site_packages(python)) do
        system python, "-c", "import libxml2"
      end
    end
  end
end
