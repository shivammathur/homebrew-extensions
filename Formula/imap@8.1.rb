# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/86bc48c9e7a5a829dab9d517a592175f2c2ea730.tar.gz?commit=86bc48c9e7a5a829dab9d517a592175f2c2ea730"
  version "8.1.0"
  sha256 "4d211816089e2282cc4710d533f4f5929918fd364a8c81096b8e42a152935d75"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 arm64_big_sur: "a3bd5ab667fb52680c46333b3b045ea568fc3e93635cad31a8b1d0440622e90d"
    sha256 big_sur:       "ae7fa60e5b4ce6fa2538050801744faece5296316ed6cb9620820f75c8f29242"
    sha256 catalina:      "e6b9bafceec2264154d22380449eb15bd06c3ae824bac071790293d88b178d9b"
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
