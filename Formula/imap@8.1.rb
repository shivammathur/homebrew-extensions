# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1611542845"
  version "8.1.0"
  sha256 "1da1e72b375fd7e43ca79907bc66be28878d8b285ca6e9b781e388d87a314f76"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 22
    sha256 "1368265d5e914b4fac8be7eacd61910c570ac3aa2323ee9e3709ce3890fde4c2" => :big_sur
    sha256 "695a573d1ef33800175a16adc96321aa598bf81beec3468d6b270a73231877e0" => :arm64_big_sur
    sha256 "c9885a7e038f40c36838b0ec08aacc1ddaf9a2557afa9641f74021bf09753857" => :catalina
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
