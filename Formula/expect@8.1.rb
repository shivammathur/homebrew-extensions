# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "890b4ecd45139a6bbcf83ed7be3d8f1129fe8e8ac1c9b74fc1758756f6a6b0f4"
    sha256 cellar: :any,                 big_sur:       "2d77626398cac9e965d013fc7514cbed9a2326f9df95210f0af1d95d0f97dece"
    sha256 cellar: :any,                 catalina:      "bf9547486bf3e28f651a19db094a3ac8623478534d630b3dcf83b9cce8df5522"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "567704f35c37d53cca28d924b8d79cfebda616dca94b8d8ea54637b6086da7df"
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
