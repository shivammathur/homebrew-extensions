class Gpgme < Formula
  desc "Library access to GnuPG"
  homepage "https://www.gnupg.org/related_software/gpgme/"
  url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.23.1.tar.bz2"
  sha256 "a0c316f7ab7d3bfb01a8753c3370dc906e5b61436021f3b54ff1483b513769bd"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gpgme/"
    regex(/href=.*?gpgme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "aba1f7b9457f4c31e8bf938753dc459e515ffacd2f81e438367d1eaf384fea6b"
    sha256 cellar: :any,                 arm64_ventura:  "2b948813ec600e32a77d1d6ab8458c98bfc1f68528f4d37ccc472421d2a66baa"
    sha256 cellar: :any,                 arm64_monterey: "4fd1e92f06f16f2587c7436a59af63677656a1f1ce686e7aab165b07c6447bd8"
    sha256 cellar: :any,                 sonoma:         "9b98727cdee464a769d48b7c809ccca4cab24010aed155015289a8b3a6e01926"
    sha256 cellar: :any,                 ventura:        "af45aac4fcc440a376968607f45885108519a4f49758bfefd21221b2bf65872d"
    sha256 cellar: :any,                 monterey:       "eef1d7f33ab7f5d27163ea78fd2b65d3f1c7755795427d7e81f8134093e97257"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fcee13a18d690b7d8b6e7a0d49e6bbcfeb52c0571ef10abcaca06ab6a874182"
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
