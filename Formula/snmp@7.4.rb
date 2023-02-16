# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c04f310440a906fc4ca885f4ecf6e3e4cd36edc7.tar.gz"
  version "7.4.33"
  sha256 "5dd84e45c5a15a19ab0918404a737ad04cadbe8b4a3408ff1a07eca0cf810946"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "49a5cad98b3675bc2858a51994f6424965dbcc0a8be61714bee97c2ad0867196"
    sha256 cellar: :any,                 arm64_big_sur:  "f8e199fcb0a283ac156c236a9be2488b50b4ceacf6988babb0b15abecee1dc5b"
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
