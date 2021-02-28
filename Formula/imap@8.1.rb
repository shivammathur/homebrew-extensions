# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1614490880"
  version "8.1.0"
  sha256 "87311804e0a9b3e9e149a1f5a4469eb065ea47483f0dbf056a22413d08662792"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 27
    sha256 arm64_big_sur: "f379599963e06696248f861efa88beef68be9f81c0fa2a2f635980ed1f5a724d"
    sha256 big_sur:       "993f31449097eafe30da66f98800dc2f8d7c8b3b0df957bfbcf0507d85436802"
    sha256 catalina:      "3a2c071ef3e0915e0ebdc394ae59258c3a8fd9ab31e90df5c214032eda577e8f"
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
