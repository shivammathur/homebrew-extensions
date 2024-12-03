# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.14.tar.xz"
  sha256 "58b4cb9019bf70c0cbcdb814c7df79b9065059d14cf7dbf48d971f8e56ae9be7"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "296fd09e98a5d6c236668b5e4faadb390e1bda754582d23442a6e8d734b58ca4"
    sha256 cellar: :any,                 arm64_sonoma:   "187c1dcf5e9063272d2e20c07be1d21a850bc368d0b65326485715ac29f1bf3b"
    sha256 cellar: :any,                 arm64_ventura:  "7611895a49aa762cdeba45d90db1dc313583f2bbe708bff7a8d777c3b73a89cc"
    sha256 cellar: :any,                 arm64_monterey: "9c4b97c5eabb4a0180e2de8b2a1599b977e7d6fc9d64ec3279c7954a1df642e2"
    sha256 cellar: :any,                 ventura:        "b54c87436f363635750aa91f3ac9a4ae7a5baeb57cbb6ea69cccc1513e83484e"
    sha256 cellar: :any,                 monterey:       "00e95e39e654aa9bdcf8a59d785d8c1d36bb7f8c7cbb1fdc9214d635fcb20dff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f4ac85d4cd809f3a49f0af6ca55dc8e6e617a29c0d64759c38f902b2e3c34bab"
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
