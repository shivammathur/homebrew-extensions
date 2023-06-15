# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/40439039c224bb8cdebd1b7b3d03b8cc11e7cce7.tar.gz"
  version "7.4.33"
  sha256 "f3406242ca682e9d694e9dea6ae5f7322134156089584fb1232269526650db4a"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "49a5cad98b3675bc2858a51994f6424965dbcc0a8be61714bee97c2ad0867196"
    sha256 cellar: :any,                 arm64_big_sur:  "f8e199fcb0a283ac156c236a9be2488b50b4ceacf6988babb0b15abecee1dc5b"
    sha256 cellar: :any,                 ventura:        "476912841a486f030b9215e4cf1ac3d8141e0d7a6df2b705215db5cdb74d434c"
    sha256 cellar: :any,                 monterey:       "fc76ab526040f13789b00321d681f8d889e6ecdc0a02c9136eee30704128cd9b"
    sha256 cellar: :any,                 big_sur:        "cdd41d757aa37fed99ce889d47f2ae4d5510b0c912d93a852f915c63fdda0145"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "641d1d4118b4513fc464d2faa2dc8d17819c571e0842ea9b11626074c08d79d1"
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
