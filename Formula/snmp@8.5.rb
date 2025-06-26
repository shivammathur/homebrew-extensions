# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/aab281546ce42f7cb1e8dfc60e231d15cc56c7f7.tar.gz?commit=aab281546ce42f7cb1e8dfc60e231d15cc56c7f7"
  version "8.5.0"
  sha256 "a7d52dbd4b8d4ddc10ff93060c942463125b75bf0e56ac14060dd57178491dc4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 32
    sha256 cellar: :any,                 arm64_sequoia: "d1cc68dd29cd1bdbf6879f1c382583dd2a575162eff9e30ece69a67739ba6c96"
    sha256 cellar: :any,                 arm64_sonoma:  "cc5f9c832a7f01b0f95eca0550b673beb582054c7169c1c9bb21f8be7dee5328"
    sha256 cellar: :any,                 arm64_ventura: "de114ed381beab7e124bb547f7b8b99f62a0746283b3798f20af221539d160d4"
    sha256 cellar: :any,                 ventura:       "07505213c144e6b0a0ef5218e94dbbcf761a8a453071ef84a365c66294b7e0b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f2e69b275a2cebaa5a60eafbebaae348390cfacdc441ffddb2b4fa833675885"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ba18efd319d518a44d597a954d88b5a6220b1c21ff149276841354281582046"
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
