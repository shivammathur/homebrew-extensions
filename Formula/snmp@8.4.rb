# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fc66f37d61f189b9f15a21ae0bd76644e1714667.tar.gz?commit=fc66f37d61f189b9f15a21ae0bd76644e1714667"
  version "8.4.0"
  sha256 "6cbb98f196e10f31311ef78aca834f9c2c6360d03e3f51a37654fee743ccfa05"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "4379d58a85e57511b4d83c0b57eb7c8f8cb51f114527f05a83ca30de24ff758c"
    sha256 cellar: :any,                 arm64_ventura:  "fd286c24079b4492d501f269b98fccf8a0c2f67f9448db003c5cf927ad35a4b4"
    sha256 cellar: :any,                 arm64_monterey: "f66a5b0c4bbd4893983db4a0866ceb3e2b7e00b8a9f6f1fd10f8401baeb39a97"
    sha256 cellar: :any,                 ventura:        "87b48b6beb5b186e457ca6422618e07f85badd364b1ab969bc776baf04273533"
    sha256 cellar: :any,                 monterey:       "3d37db07666d940cb009594c1f5ceb43b1e69e6c548ef82bc46b5fe1e63a2729"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc2610b16b4547a9dcfb4981a0171f743a20092bd9edf9d7c43d6ef677a4e543"
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
