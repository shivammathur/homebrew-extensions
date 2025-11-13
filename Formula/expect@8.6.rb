# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT86 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "a3acabcdf127789d267e345d7d547d11302a7c311689dad9d8ee4a72d9cbfbd1"
    sha256 cellar: :any,                 arm64_sequoia: "8614ab6b62d87d0684c4231340e7f301b432b50cf50389da2bed63140739ddf3"
    sha256 cellar: :any,                 arm64_sonoma:  "f4213042bd9c1a2fbbe6d654ad4371ce95e5a52782460f3f5cdbfc9729e0695d"
    sha256 cellar: :any,                 sonoma:        "e8e62c26037925a511e8d7c2e25480139e53b924f59547aff78494adfd9c8bd7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb6e5fc407d9eca57e9025b0fe4312340b747bc252b04763c1ef4e0850b40b97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1793e48ccec9e5894ea93603f5f515a09b4de5334071eaa4642658c20d7f2afb"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    inreplace "expect.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "expect.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
