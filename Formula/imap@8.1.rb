# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=e496123c36107eead3981c3f0aaa1d95653d70c4"
  version "8.1.0"
  sha256 "a238f008191895a8f1b258d8d7bfa0142912d5456c447498c7a32d64f5debc0b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_big_sur: "9b04cd0c6ad084674b81d2abbd090e399e667808b5fae46f589f66bab99c5195"
    sha256 big_sur:       "d80c8114d060b84d1faa07b063837c259454289beaaab959aa87216cca957f37"
    sha256 catalina:      "5fdf15291b6c3806729c4321787747545adbd1b46424cc5598a87091f6760ada"
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
