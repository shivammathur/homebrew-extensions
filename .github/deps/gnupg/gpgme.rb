class Gpgme < Formula
  desc "Library access to GnuPG"
  homepage "https://www.gnupg.org/related_software/gpgme/"
  url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.23.0.tar.bz2"
  sha256 "043e2efe18b4ad22b96d434dde763fbed32cf8d6c220dc69df0d0ffb9dc66fc6"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gpgme/"
    regex(/href=.*?gpgme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4a520c7f85e62ab5598e8f8ccfb3aa5f5133acf683ee7070d8561f06f5f8c8e5"
    sha256 cellar: :any,                 arm64_ventura:  "9e66f2cbb080fff055a2e6f28a15e2c0a2ed5ac921b779d529ac244f4993b33b"
    sha256 cellar: :any,                 arm64_monterey: "56ba957ef026756d761e503275266038ee946761b4f5aba95f04dd10d24d1ef6"
    sha256 cellar: :any,                 sonoma:         "ddb595e3cd4ee40cdabe4b871573ae9420f1f8ecbc3398f8d62511d287db7632"
    sha256 cellar: :any,                 ventura:        "204672aaab3b63edbae250a20db8cd0ebab76479e88bca55354ef90432aeaad2"
    sha256 cellar: :any,                 monterey:       "f0c6edffae9fc81481bc467084b6255dbe1c070054fece0429dcc453a028aec7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4343fd7d36c0593d220ce6eb7912c75a10584ccb5bbb4ca7d528ae4cf64d944a"
  end

  depends_on "python@3.11" => [:build, :test]
  depends_on "swig" => :build
  depends_on "gnupg"
  depends_on "libassuan"
  depends_on "libgpg-error"

  def python3
    "python3.11"
  end

  def install
    ENV["PYTHON"] = python3
    # HACK: Stop build from ignoring our PYTHON input. As python versions are
    # hardcoded, the Arch Linux patch that changed 3.9 to 3.10 can't detect 3.11
    inreplace "configure", /# Reset everything.*\n\s*unset PYTHON$/, ""

    # Uses generic lambdas.
    # error: 'auto' not allowed in lambda parameter
    ENV.append "CXXFLAGS", "-std=c++14"

    site_packages = prefix/Language::Python.site_packages(python3)
    ENV.append_path "PYTHONPATH", site_packages
    # Work around Homebrew's "prefix scheme" patch which causes non-pip installs
    # to incorrectly try to write into HOMEBREW_PREFIX/lib since Python 3.10.
    inreplace "lang/python/Makefile.in",
              /^\s*install\s*\\\n\s*--prefix "\$\(DESTDIR\)\$\(prefix\)"/,
              "\\0 --install-lib=#{site_packages}"

    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--enable-static"
    system "make"
    system "make", "install"

    # Rename the `easy-install.pth` file to avoid `brew link` conflicts.
    site_packages.install site_packages/"easy-install.pth" => "homebrew-gpgme-#{version}.pth"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace bin/"gpgme-config", prefix, opt_prefix
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gpgme-tool --lib-version")
    system python3, "-c", "import gpg; print(gpg.version.versionstr)"
  end
end
