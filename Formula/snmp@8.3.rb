# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.17.tar.xz"
  sha256 "6158ee678e698395da13d72c7679a406d2b7554323432f14d37b60ed87d8ccfb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "aff71ba14bbd7881d6a7822c4be5d0ece3e73738300d029f4f39685caa7c6d61"
    sha256 cellar: :any,                 arm64_sonoma:  "b57074f02dc5b4621cbd2653fc3cb0429e8de570d8273c4607fab453b90556b5"
    sha256 cellar: :any,                 arm64_ventura: "573b5f8164a0b783241d75be0f94b8d897727bddae9e1d39bc8727b380468450"
    sha256 cellar: :any,                 ventura:       "dd8196e13f2518a4a59b1825b5756f14b37eb4fa73da611846c763d0e8ca515c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e296970c91f848371103810ce08be7321727e8c6c7eac4eac8cd4e3119e05c57"
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
