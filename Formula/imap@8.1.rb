# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=339ce9430ebeeae146bb8d59c865ad4cedca7b59"
  version "8.1.0"
  sha256 "0521e0ed7b86af7061d2c3e8629d1fd107b446c261111180deed4ef1831ba123"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 arm64_big_sur: "49af8624f9c164d2263bc7c827ad7c344a704ceb2a9e0922a4a1d7fcacf24f14"
    sha256 big_sur:       "4616ea522716733eb4c2dc082f9df7f6f843e2b18d8177de664ac1adb26bca8a"
    sha256 catalina:      "6bfedf6be562b257833a33dce7086a04d9c4b53da23f3badcf5efc50f32f2f17"
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
