# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/24082d54927c042170d9c3939aae4431cccfbad0.tar.gz?commit=24082d54927c042170d9c3939aae4431cccfbad0"
  version "8.1.0"
  sha256 "3c6143a5910f27a3aaeea52ce7b0b9c8d97449bba93f27b11adcc83cd07e451d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 22
    sha256 cellar: :any, arm64_big_sur: "412010f32ff0e5524347b20a07fad4d13e712c9b9125555c3e1f92c61a08a4cb"
    sha256 cellar: :any, big_sur:       "4f840113176c3f5aa0ef31d6bd41b98403472c733a5c07bcce528180f962b940"
    sha256 cellar: :any, catalina:      "259337e23ff6ba2c356488972978963da9519ce268bb2db87ccf6c3e26c1a37f"
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
