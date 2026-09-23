# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "11f64b3bd506c05b35bc449db86e5f41e25462a85b4072043752a2ec876d2b20"
    sha256 cellar: :any, arm64_tahoe:       "2af835914e47296489596158ce4cad3169f7a8ecf3355f629b4e49387710435f"
    sha256 cellar: :any, arm64_sequoia:     "9b9f1f5d210d05a7f5287f1507b089c206f55ab763551987563736fc3f4cf6e8"
    sha256 cellar: :any, arm64_linux:       "0fed525d20c528f056308b5bd1fb93ffc7126369d3994fbd2a618f4ebc85cd3c"
    sha256 cellar: :any, x86_64_linux:      "cf7f9158420d50f108c3f213bcb482d0551b45de9d347f99c0a9cbcbd0a675b5"
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
