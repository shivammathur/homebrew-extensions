class Gpgme < Formula
  desc "Library access to GnuPG"
  homepage "https://www.gnupg.org/related_software/gpgme/"
  url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.23.2.tar.bz2"
  sha256 "9499e8b1f33cccb6815527a1bc16049d35a6198a6c5fae0185f2bd561bce5224"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gpgme/"
    regex(/href=.*?gpgme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "56ee3e87783f3d5783b26ba855c744559d5a4ce6ff0899b3e489bffdaa370f41"
    sha256 cellar: :any,                 arm64_ventura:  "0e1048e120c39e3c2af3737a218203e5cd141d704f3b333f582e8d7273c3f5be"
    sha256 cellar: :any,                 arm64_monterey: "3ac0f229a561d097e29e0fd2e71417ced8ce5c5a85d8b61c99099e1dcbfdbe3c"
    sha256 cellar: :any,                 sonoma:         "2eb534cb5adaa9f44fcdc43fc3fe22e964277e04daaac3366ac5b1ff19826fd4"
    sha256 cellar: :any,                 ventura:        "b28537f38f9ba61ab5d0e530fb067ae23e48c9a5eea4418b5b11fdc64858116d"
    sha256 cellar: :any,                 monterey:       "f4c9120e205b8d023bcd1e019446b080ea1c89d759b9fb5724351d7fadc95166"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c164a32c1038b62a9e9d9fe968ba55828970f829435b46e89757c81f30152d8"
  end

  depends_on "python@3.12" => [:build, :test]
  depends_on "swig" => :build
  depends_on "gnupg"
  depends_on "libassuan"
  depends_on "libgpg-error"
  depends_on "python-setuptools"

  def python3
    "python3.12"
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
