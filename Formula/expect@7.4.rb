# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "1ae122f26a7e40af93f143c12c415679cf64a2057bea6509b547e602f0ac2869"
    sha256 cellar: :any,                 big_sur:       "68d85655e680f0ba60bdc14803fd0c3d0de19f73f0895512f0972c8a15a6f75b"
    sha256 cellar: :any,                 catalina:      "5fae15f0f8d2f84757c1afa6f69508d341548cd1d834f7375de189964b75d336"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88f8205b6c5f0449db97ad5fada4d95f4196ea97602ac8b2c81de041d4a03029"
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
    inreplace "expect.c", "ulong", "zend_ulong"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
