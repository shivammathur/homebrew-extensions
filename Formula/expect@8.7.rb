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
  revision 2
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "68657301d8f89308dfbea89d1424bc0733e6639f2a957048c6a0c95fdfae6806"
    sha256 cellar: :any, arm64_tahoe:       "e8a9394cf73a2d3fecf5f6f6428fb7f988d7006feafa52f9185b1be7d572d277"
    sha256 cellar: :any, arm64_sequoia:     "1792713b63c852f25c84757f6d2ea5502a84a1a37a84029a287751e9e04f2159"
    sha256 cellar: :any, arm64_linux:       "74821065af8866fd3ae2b51586ca045077f89ce400feefdd6a9dd5304a3fa8e2"
    sha256 cellar: :any, x86_64_linux:      "eb76a94ae82d86e04fc6b0465ea3f4dc5b18496208a1c1386f0ca107d4dad160"
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
