# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.3.tar.xz"
  sha256 "b0a996276fe21fe9ca8f993314c8bc02750f464c7b0343f056fb0894a8dfa9d1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "922d229e6328670a04c316ba1dd5686c3c11c956e4e41a8be7fdeda85f4837b9"
    sha256 cellar: :any,                 arm64_ventura:  "affaa4f207f1e883c4a8f5960fed06ede93c4b05cc33be701859974401a284f6"
    sha256 cellar: :any,                 arm64_monterey: "2a69c0a3bb8f4dda01d3819fc01d534f6d45e006f0de0be7886dac46dbb5484b"
    sha256 cellar: :any,                 ventura:        "87282e95058aab0677de6085b82d37e1214ff92fd30c4ad9bfcbf201edcd9c11"
    sha256 cellar: :any,                 monterey:       "defa95b3e8943d12596762503e033cefb82d75b71869e7f56de4bee7c2db2f49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98f4dc226d1d83ad0b22d2700642e760217295780a9e518b8d3dc0ce66ec90e6"
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
