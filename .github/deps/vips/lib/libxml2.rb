class Libxml2 < Formula
  desc "GNOME XML library"
  homepage "http://xmlsoft.org/"
  url "https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.4.tar.xz"
  sha256 "65d042e1c8010243e617efb02afda20b85c2160acdbfbcb5b26b80cec6515650"
  license "MIT"
  revision 4

  # We use a common regex because libxml2 doesn't use GNOME's "even-numbered
  # minor is stable" version scheme.
  livecheck do
    url :stable
    regex(/libxml2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "3211945521a13a278641145097b44c242a91afb03819efdce733dd2a39b4ca9b"
    sha256 cellar: :any,                 arm64_sonoma:  "c7661433ff9cf455314ec3bd7fa0cc15debee3df74e6c894f82707f804471f7d"
    sha256 cellar: :any,                 arm64_ventura: "7d218dd815b26bf68e824b45e491bbad0d4e8c5c8246d8bbe5f6de784815d788"
    sha256 cellar: :any,                 sonoma:        "c3f316fa073279036b0c81fad21d158ddac26a30d0a457be67b753bb8fcdc2b5"
    sha256 cellar: :any,                 ventura:       "7e48fccee11b2ee6d789460b57e1ac3b49c42297be839f05361bcfff61795b73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29e6b3900187de9084702abb031c991f7918b1d44b8084bec2c52d7d37ba6a0f"
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
  depends_on "python@3.12" => [:build, :test]
  depends_on "python@3.13" => [:build, :test]
  depends_on "pkg-config" => :test
  depends_on "icu4c@76"
  depends_on "readline"

  uses_from_macos "zlib"

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    # Work around build failure due to icu4c 75+ adding -std=c11 to installed
    # files when built without manually setting "-std=" in CFLAGS. This causes
    # issues on Linux for `libxml2` as `addrinfo` needs GNU extensions.
    # nanohttp.c:1019:42: error: invalid use of undefined type 'struct addrinfo'
    ENV.append "CFLAGS", "-std=gnu11" if OS.linux?

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--disable-silent-rules",
                          "--sysconfdir=#{etc}",
                          "--with-history",
                          "--with-http",
                          "--with-icu",
                          "--with-legacy", # https://gitlab.gnome.org/GNOME/libxml2/-/issues/751#note_2157870
                          "--without-lzma",
                          "--without-python",
                          *std_configure_args
    system "make", "install"

    icu4c = deps.find { |dep| dep.name.match?(/^icu4c(@\d+)?$/) }
                .to_formula
    inreplace [bin/"xml2-config", lib/"pkgconfig/libxml-2.0.pc"], icu4c.prefix.realpath, icu4c.opt_prefix

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
    inreplace "python/setup.py", "includes_dir = [",
                                 "includes_dir = [#{includes}"

    # Needed for Python 3.12+.
    # https://github.com/Homebrew/homebrew-core/pull/154551#issuecomment-1820102786
    with_env(PYTHONPATH: buildpath/"python") do
      pythons.each do |python|
        system python, "-m", "pip", "install", *std_pip_args, "./python"
      end
    end
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libxml/tree.h>

      int main()
      {
        xmlDocPtr doc = xmlNewDoc(BAD_CAST "1.0");
        xmlNodePtr root_node = xmlNewNode(NULL, BAD_CAST "root");
        xmlDocSetRootElement(doc, root_node);
        xmlFreeDoc(doc);
        return 0;
      }
    C

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
