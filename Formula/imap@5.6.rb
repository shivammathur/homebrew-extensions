# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhp56Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://php.net/get/php-5.6.40.tar.xz/from/this/mirror"
  sha256 "1369a51eee3995d7fbd1c5342e5cc917760e276d561595b6052b21ace2656d1c"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 "e6b911ea8bce9c103cebc90ccdee151a9686369bc2db93457691c7befadfdab2" => :big_sur
    sha256 "74e89526344fe5096590926cebb77ca9d400cf7ae82065b6f4568cc45b404b10" => :arm64_big_sur
    sha256 "6a81466c0b940fac11bcf7fe9a0d725d735ebaf3e94f9ed4b26981f21573f324" => :catalina
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
