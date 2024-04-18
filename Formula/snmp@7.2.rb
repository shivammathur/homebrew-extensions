# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/fd96daa9aae7a1c43be03fb261bc54f6d3692e06.tar.gz"
  version "7.2.34"
  sha256 "9428386bdcfc4b3e64360dcd906368ec457a909775913605d8f6514c3ae5b291"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "79557550230ab2f28beb9ae44f313df7015a0767d94c297a3052402c82a531ce"
    sha256 cellar: :any,                 arm64_ventura:  "a6a643cad679bae3af9b14bbe6713b1edd0a1b8190a06cb4f0f34c66868ce41b"
    sha256 cellar: :any,                 arm64_monterey: "f2cf8d4b9dd395c5ad4bb12876a70ca6ff586baf713440fa9f8c9a685307c798"
    sha256 cellar: :any,                 ventura:        "6ddcb653b6d57a8a873e53f3a5c766d1407189a441dbc56464ad285c9ebf6107"
    sha256 cellar: :any,                 monterey:       "b5f48481d35d096a608c1f74e0a1454baf34a1880f6a2724428338aff00b1ac2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01cac9111362a00962bc7058e4e786ec57bb3c83c7255526f6abb9eb2fc775c6"
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
