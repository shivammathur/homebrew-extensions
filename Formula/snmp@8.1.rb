# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.22.tar.xz"
  sha256 "9ea4f4cfe775cb5866c057323d6b320f3a6e0adb1be41a068ff7bfec6f83e71d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "be225b6f4e48361b6ebb606cfe972db95de59995c24b2800a2c5c1d52cd161fd"
    sha256 cellar: :any,                 arm64_big_sur:  "62679f5971dd8e930cc29d9f7a324194cbc61f06f716082731191aa3b83ab6bd"
    sha256 cellar: :any,                 ventura:        "e7b2a407473ba4a31b5cea48afe8e82e36db7d7b33253ecca960cc611f99c432"
    sha256 cellar: :any,                 monterey:       "503f96d4e7877455b3f110f5685a8ee2160fc3c25e8ecdf2acd7e5f6190ab092"
    sha256 cellar: :any,                 big_sur:        "7c07f86d61a473144dad5d02ee09660ee4b9922189db2fe4519761e9f0fa29e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01a6b1b2e386484e32bdd3b0116231b8fc6bdfedb6e9a58914ea780666d684d6"
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
