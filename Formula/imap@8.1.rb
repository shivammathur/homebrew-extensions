# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=7358457aa72acf10dd201970aecd1b1154b3ea0e"
  version "8.1.0"
  sha256 "55a3f064be684cf6d0c5798447bab9eb5be39d0971896d798a36a277c87a3e43"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "af3edff044fc99c04650982eb7d79a15dc195ea67146d6d8df57ca6be4403432"
    sha256 big_sur:       "678d0f6be078ff6b995f5eb1ecac71346f8012179119236f9810cd33922be42d"
    sha256 catalina:      "3ef14a59b8a92f378e34b38d9e50ab3b75bbd5547ad55dac3af5957f68e21444"
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
