# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.29.tar.xz"
  sha256 "14db2fbf26c07d0eb2c9fab25dbde7e27726a3e88452cca671f0896bbb683ca9"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2e566b8f023694c0cf5849fcdf88ac20fc708aa1af9ff61fb5ab86272d3730c1"
    sha256 cellar: :any,                 arm64_big_sur:  "21051efbfed0fbca3c84ede22a10e58f6329aa1eeb98629eb1f6ce38385e14d2"
    sha256 cellar: :any,                 ventura:        "580aa61fe63a54ce2a61219372af60efe3d75a0251d596fe00a27fe468ff00a9"
    sha256 cellar: :any,                 monterey:       "78c4d6bc4bedc607a20b1c1cf2c582781460268e35e5779f99b0b541b37745f2"
    sha256 cellar: :any,                 big_sur:        "129e1d2340d313dea4daad3067663c2ec3714dad00f535f639c18007cf17a335"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60658e2bf021f1a7debb3b6314ba8bbbb891314910718c383e242f8ec59c8733"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
