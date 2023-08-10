# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/745b6220ed05d9a4a3302371b8d2ceb9ce7c287e.tar.gz"
  version "7.0.33"
  sha256 "3c7b35935e47d72e43cee7fcff2252b37000819f512235c6b314b184c588329f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2dc3b146203c5d297c919c1ae416a4cd245259329feca58eb7b4d961253c9b04"
    sha256 cellar: :any,                 arm64_big_sur:  "af45a6e422a7733690e72b992e06f3c94341cdac2d22800c95c025b7af242ad9"
    sha256 cellar: :any,                 ventura:        "a647e8890e136816cf5c51573d2928643ff807190988549b26a462bd98b38977"
    sha256 cellar: :any,                 monterey:       "9c424c9d17a79d96d0a20ba8155fd2fc486a6cfb539eb232dbf54a5f9f28abba"
    sha256 cellar: :any,                 big_sur:        "52a8dca5bbd4230348448cc93955d2db3b344f47fab21a4adbcdf405eeeb032d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb3de29139caf568d27b557496170578a0b85cf4f5437c404afcbb474493a7d2"
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
