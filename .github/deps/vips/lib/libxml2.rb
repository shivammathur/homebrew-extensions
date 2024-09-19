class Libxml2 < Formula
  desc "GNOME XML library"
  homepage "http://xmlsoft.org/"
  url "https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.4.tar.xz"
  sha256 "65d042e1c8010243e617efb02afda20b85c2160acdbfbcb5b26b80cec6515650"
  license "MIT"

  # We use a common regex because libxml2 doesn't use GNOME's "even-numbered
  # minor is stable" version scheme.
  livecheck do
    url :stable
    regex(/libxml2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "28b2523edb939ceb85216103be88e994a156a4f0157a045ce03bb2418239926a"
    sha256 cellar: :any,                 arm64_sonoma:  "3e95a731b533d2151d0ba3924d38459db34dc1b09142bd5388c38489c690c05b"
    sha256 cellar: :any,                 arm64_ventura: "f9e6108a1f2564a54155cabf79c5b62d1472a3ccf7e3bd87a11667cebd9e149e"
    sha256 cellar: :any,                 sonoma:        "f2ee23b587e3d0390cae43a9c396f417ecd66ba599ace888983914f8c3ba91ca"
    sha256 cellar: :any,                 ventura:       "6a407f5772c16f7e4faecf439e0df8bbffbd6df53a7214981e45b9a8b9a8f029"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07d2aa6c77733470aee3cfddcd2e9159f1ea4184a297cfc2de33d9e5038ca728"
  end

  head do
    url "https://gitlab.gnome.org/GNOME/libxml2.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  keg_only :provided_by_macos

  depends_on "python-setuptools" => :build
  depends_on "python@3.11" => [:build, :test]
  depends_on "python@3.12" => [:build, :test]
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
                          "--sysconfdir=#{etc}",
                          "--disable-silent-rules",
                          "--with-history",
                          "--with-http",
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

      # Needed for Python 3.12+.
      # https://github.com/Homebrew/homebrew-core/pull/154551#issuecomment-1820102786
      with_env(PYTHONPATH: buildpath/"python") do
        pythons.each do |python|
          system python, "-m", "pip", "install", *std_pip_args, "."
        end
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
