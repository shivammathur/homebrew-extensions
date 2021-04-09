# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=4034d83432a9d4b1d3c8d334d382871e4146f664"
  version "8.1.0"
  sha256 "74876c13e44794ded8b9484f52959f9d6d2f30281cf0f12200148906779c9d84"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 33
    sha256 arm64_big_sur: "bf55c55d97f74c365f3e5b221fc2c551ab7901957817b3b1ba1fc3243b712f85"
    sha256 big_sur:       "08c70d38141a880b0b85a1b8c724a34b1dfd701cd4bbeb9d2b19351d75d0de2c"
    sha256 catalina:      "92deb6e3488da0e7ebb2ae1e3a1c46f660d2984a69f15d765441a69093928fef"
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
