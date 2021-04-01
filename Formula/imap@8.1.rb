# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=83b01a920ec16175d4459a8c30d7d4090197f269"
  version "8.1.0"
  sha256 "8f0935e4eee86cc267a6f3ac2d8e58bddb566b8a5c17088aaa1d8d24f7ae4424"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 32
    sha256 arm64_big_sur: "6f71922c7c76a2f88ff2e6424e49b98a1dc55542241f41b51178d5418889e7b8"
    sha256 big_sur:       "ad78f0d51001e1b1e703290880cd2cd84a3bc3895a66068d1e56bac536094588"
    sha256 catalina:      "6218e91c138f1ef6b9369b69e56c1a7ef3c2257056094b48abba912c2fa7385c"
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
