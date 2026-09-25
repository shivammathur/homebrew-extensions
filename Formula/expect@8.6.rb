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
  revision 2
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "bddbb98613a1fe30fc4ec265c44cc243e31d225fe1459c0534c7c57e90a23fb2"
    sha256 cellar: :any, arm64_tahoe:       "f69abe59382b69588da60c2bb5fedf1be15be14195fd2242957f52ee897eb181"
    sha256 cellar: :any, arm64_sequoia:     "e63920894d5c04a01aa50fd755d1c2fb0f44c4f2fa5380f4e04c7ed662de1e98"
    sha256 cellar: :any, arm64_linux:       "d8ccfb9cf59d10655a2d9eca4d06e6ea5009bda25c7774fe4f0655efb1da7eb8"
    sha256 cellar: :any, x86_64_linux:      "80f73c816f931f7385568d41a53971bd602067706c62034cb6b29c29743f74d4"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Utils::Path.formula_opt_lib("homebrew/core/expect")}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Utils::Path.formula_opt_include("tcl-tk@8")}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
  end

  def install
    args = %W[
      --with-expect=shared,#{Utils::Path.formula_opt_prefix("expect")}
      --with-tcldir=#{Utils::Path.formula_opt_prefix("tcl-tk@8")}/lib
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
