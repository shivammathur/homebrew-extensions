# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1612411617"
  version "8.1.0"
  sha256 "5d992f4b2f31e86c71e0b81998c15f0a343a9d145e0e44ef3996fc832b74d391"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 25
    sha256 big_sur:       "806da3e139b852c6704edb6627e8f356df9a511b29ef0c2ec7d25603e45c8a11"
    sha256 arm64_big_sur: "b5f7c40fb39cd60c5ce57c2df8b70ae24ec7df2a103df95f89e8484ea6d0ac47"
    sha256 catalina:      "67b7f8438c511c401e12d162a4f6ef8400f4ef5c3384e388565d5b3d76270ec9"
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
