# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5.6.40.tar.gz"
  sha256 "ba815dae9ab81326a0971bb44a43baf91940d903239f3dd31b2a4e34e40e074c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "6c358e49bf563ce2b60f808c6f8d3053d56ed0d4f0bb0e21f77dbf49cd977f3e"
    sha256 big_sur:       "8eb7d70f5f017a4200792a0d2fff0272fa624df0d89cf842fc54ab521cfa7d14"
    sha256 catalina:      "0f9b4459367356b3e97d5400d1a5198ffbb57570d2f194e330bf9d4278b1ff28"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
