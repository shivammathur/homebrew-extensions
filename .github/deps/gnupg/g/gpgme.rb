class Gpgme < Formula
  desc "Library access to GnuPG"
  homepage "https://www.gnupg.org/related_software/gpgme/"
  url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.23.1.tar.bz2"
  sha256 "a0c316f7ab7d3bfb01a8753c3370dc906e5b61436021f3b54ff1483b513769bd"
  license "LGPL-2.1-or-later"
  revision 1

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gpgme/"
    regex(/href=.*?gpgme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "e3568623e7bfa4d7dee6903eff925f8f255602d26255900399e23c720728192d"
    sha256 cellar: :any,                 arm64_ventura:  "989ee41879e1db38b52906f6551b3f620f57acd518337bbf88953f1dc73fc855"
    sha256 cellar: :any,                 arm64_monterey: "44b894bdb8a84b6d3c47804bcbfbdec9dbb336b9e121042d47da47d4aa6d1007"
    sha256 cellar: :any,                 sonoma:         "2ef15d47117a53dbbe68b96c8fe1500aa0d454985c5595e4d065661bbf07fb70"
    sha256 cellar: :any,                 ventura:        "a763f60e7824ba95264ff0e25e46616cbfd26944522fe0dc6169e85545dd53d2"
    sha256 cellar: :any,                 monterey:       "c11ee9d3913848f62a7f9699e358aa3a9e177be948dbe55414fd22bb7ed63e47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec16603d2d8f7f10f1e9c4790717091f374557df0e145cd54edfd86e98f7fe45"
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
