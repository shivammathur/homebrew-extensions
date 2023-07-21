# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6dd0dcf6e1eeb3f6fcba9b3269ca0803d7bbaa2d.tar.gz"
  version "7.2.34"
  sha256 "7aadc0a75d70efb425f8d74ea9e1a4a6826d5adfaa9807ed8d034d7cef1a7aff"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "0da16e1303c0acf7de8521561e1dec06d68f53cd422e486e9f1ebd8a84fbb510"
    sha256 cellar: :any,                 arm64_big_sur:  "52c32af517179e87a921e5e10c7bf8b643d7d015978d3b197b5c5c9b5ca412b7"
    sha256 cellar: :any,                 ventura:        "c9f4dbdf9fa63c4fe30bef124ca8f6b17e6ea66cbd607cb27786f29ec67570ae"
    sha256 cellar: :any,                 monterey:       "b9108195f2cb7e637809a71ab50016b83496d05edf2baad077d7e55b651e6cba"
    sha256 cellar: :any,                 big_sur:        "a44fbf1296624af874a889903729bbf28ae5645fd8cfaf310d53d4bcf2dae3c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77ab668479a203092d6fb9527c83373381436dbffa45292b424fba56b5d15c7d"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
