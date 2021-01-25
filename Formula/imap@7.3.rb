# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhp73Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.26.tar.xz"
  sha256 "d93052f4cb2882090b6a37fd1e0c764be1605a2461152b7f6b8f04fa48875208"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 "f2c2502270b53581c6aebc33d6c0d91b6fdd3f3f2e9d19f6a8c46618b3396b5b" => :big_sur
    sha256 "c3d60a248ea9846c32de8aae2d2b211ce6ae252216d9fb79879ecc41c14e68bf" => :arm64_big_sur
    sha256 "3b56f683b2727dbb3ceeec06271d3a56599d04aa902ef90feed8bd9bd7f8d0b0" => :catalina
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
