# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT82 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "833e257d97ebb3a7ae59eb499b7c9395be426d00d4394024f3e4e1fa53b85eff"
    sha256 cellar: :any,                 big_sur:       "5cda292469b8a9815b6023fafbdd184e472f9b2ab07c4f29496a0c19adf4714b"
    sha256 cellar: :any,                 catalina:      "e5f18ebc22aae3f8fb8bf216dca0a8dd438b2e3a7281c404bd7123f28999b55e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d0323d117fcd1154d6b10e224b6b7ca08ee897293c26ac63a1d4002d757e4c5"
  end

  depends_on "expect"
  depends_on "tcl-tk"

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk"].opt_prefix}/lib
    ]
    add_expect_lib
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
