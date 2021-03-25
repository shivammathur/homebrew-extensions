# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=6c89359124e7d8d49ef8a4b61ad93118555bb280"
  version "8.1.0"
  sha256 "b35b1c899c87d6678b62e81c6e59e0730ffbdc0979a529e6f88f3e05087ea1f7"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 31
    sha256 arm64_big_sur: "cfbf5d2491364177cbac66ce1c9601ee5dd05be3164418803eb9c46f0fe9698b"
    sha256 big_sur:       "ba34321afe076e2e32d55badf29fc68066d32faf43d76a448e3d03318b9de6e7"
    sha256 catalina:      "a4086c944d88f60e54e3222143d192ec2954dec6633423092a421f60d33c7cc1"
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
