# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.26.tar.xz"
  sha256 "0765bfbe640dba37ccc36d2bc7c7b7ba3d2c3381c9cd4305f66eca83e82a40b3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1745d2fb92eccbb1aa32988e9bff3817174f2b8f0d402a2630d2305f6b3e4fec"
    sha256 cellar: :any,                 arm64_big_sur:  "9567976043196f30db85577ed1c4b00c8c6a48b8c77942579b623070b38934eb"
    sha256 cellar: :any,                 monterey:       "c099f17bba64d8ab1a0ebc07b06623e0b2703dbc504d2d16b99a3d8e1b5afda2"
    sha256 cellar: :any,                 big_sur:        "16f1b18b032161166042ab33b21f5760a4fe4c90fd378e85539277ff12a7d1ce"
    sha256 cellar: :any,                 catalina:       "35df6d9a9580850b9b04d5bb6cda539cdbdf62268cdcb98dc094374c318a28e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14053fc6a712fd51fa6cfe44c7b899f5eb855249e70cfaf7fd0cdc1183b3f3a1"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
