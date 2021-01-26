# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1611634646"
  version "8.1.0"
  sha256 "e8a9adf7bf7cd8f54729e03f315fb96dbcc4a898b1cfb8296a0cde600604ba57"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 23
    sha256 "607289ada91928c25f39231511ec6c8bbe9c695873b946b443223546b943c2b3" => :big_sur
    sha256 "2f92b0cb0f00effa917250068abf991524dd3e2d672cf2b7877677ba707bed6d" => :arm64_big_sur
    sha256 "1319eb3063fe6e5b5c7e5ab391bd3150c3c6e8f5ff3c02c5d31667c8fc152c08" => :catalina
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
