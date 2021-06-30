# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5.6.40.tar.gz?commit=82b3778dcb7ad665e6fd299e0c811bb94195bf49"
  sha256 "126babc2c65082a18cacb900bdf30f56605bf10469c5decd8c9224985e504016"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "52c5dc54131ce76a3e1db88256455f6f1659bb59fc892446ff418533d71bd612"
    sha256 big_sur:       "8bdb1d17d836328c057b4f19cd097ad8d57d0ae05fa7c0127a8ae912d1333b88"
    sha256 catalina:      "70254bd9aab2d2138221892b6c9dbce1c805a476bedda172a933e9450f807c71"
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
