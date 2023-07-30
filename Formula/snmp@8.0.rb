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
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "553f415cca7dc6fe82da2fa27b80657b3ed795cf16e34a84596b8a05585bdc2a"
    sha256 cellar: :any,                 arm64_big_sur:  "feee07fa5b10610107e1af4c8e3123bc2c96bc5fcd3bd0ca7f49f36705775e2a"
    sha256 cellar: :any,                 ventura:        "68974eea64e729330797f28d811a2affae42a476aba5517242b841fcbb5bdd76"
    sha256 cellar: :any,                 monterey:       "d0cbe2a3c198b7463b02b5ff079348d1ba1a5cd6c4240e01aa4eae1d5ad64afe"
    sha256 cellar: :any,                 big_sur:        "b0f900c96488524b070964f07d822ed37c03f52df858c3b5bd2d7d5552a648b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "184bee25c9c396341f9d264666612e1090051c0a3a16689c90db4cb5766a4d38"
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
