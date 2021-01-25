# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhp71Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.1.33.tar.xz"
  sha256 "bd7c0a9bd5433289ee01fd440af3715309faf583f75832b64fe169c100d52968"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 "158cb62e7b76b7f4758816e381ab319784a7775e2cc4aa3341e286878fa3276c" => :big_sur
    sha256 "894d2119c94ca916e93bfefb27bf2adfdb41e57681e5b5b0c6c9c7d9187b96cd" => :arm64_big_sur
    sha256 "d506e0fd56f3eb4883022c3ddfe131ec34cfb8e6d406ae73a8ae92ab73a93cc1" => :catalina
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
