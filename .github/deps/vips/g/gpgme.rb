class Gpgme < Formula
  desc "Library access to GnuPG"
  homepage "https://www.gnupg.org/related_software/gpgme/"
  url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.24.0.tar.bz2"
  sha256 "61e3a6ad89323fecfaff176bc1728fb8c3312f2faa83424d9d5077ba20f5f7da"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gpgme/"
    regex(/href=.*?gpgme[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "78c81de80215bee3d83cb1fc44eb2879b43c95db1bd5485f94fe27bb6a92b660"
    sha256 cellar: :any,                 arm64_sonoma:  "b8ded7959409a8be4698b2a197244078ebd01f07e7e97420fc2b127cdd63fa73"
    sha256 cellar: :any,                 arm64_ventura: "9959f29142bc193839ed1c812c3394be30cab3989059759e83f60c2fdaba5dea"
    sha256 cellar: :any,                 sonoma:        "45980c9bc5d6c15c5766b247db1cf43dab13aeb1f8c4110fc9db288dd01fa113"
    sha256 cellar: :any,                 ventura:       "b0901cdec310a522dfc6d2e588c9c3f621d1d6a35c7d884bf2874bbfdccf27fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1254e2feb2e8aa071dc0f998c81799ee1d8b85c0d08028c78372f8bf3b8f988"
  end

  depends_on "python-setuptools" => :build
  depends_on "python@3.12" => [:build, :test]
  depends_on "swig" => :build
  depends_on "gnupg"
  depends_on "libassuan"
  depends_on "libgpg-error"

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

    # Use pip over executing setup.py, which installs a deprecated egg distribution
    # https://dev.gnupg.org/T6784
    inreplace "lang/python/Makefile.in",
              /^\s*\$\$PYTHON setup\.py\s*\\/,
              "$$PYTHON -m pip install --use-pep517 #{std_pip_args.join(" ")} . && : \\"

    system "./configure", "--disable-silent-rules",
                          "--enable-static",
                          *std_configure_args
    system "make"
    system "make", "install"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace bin/"gpgme-config", prefix, opt_prefix

    # replace libassuan Cellar paths to avoid breakage on libassuan version/revision bumps
    dep_cellar_path_files = [bin/"gpgme-config", lib/"cmake/Gpgmepp/GpgmeppConfig.cmake"]
    inreplace dep_cellar_path_files, Formula["libassuan"].prefix.realpath, Formula["libassuan"].opt_prefix
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gpgme-tool --lib-version")
    system python3, "-c", "import gpg; print(gpg.version.versionstr)"
  end
end
