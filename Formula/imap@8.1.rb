# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=590af4678bbdbb9422bfcc568a0b8d2d1a6f74f5"
  version "8.1.0"
  sha256 "89734e9f78d9f66a1553871542cbd43737597bc5e415776ca6e8a5e0f5a43c23"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 arm64_big_sur: "a652921c1f1048a4dd19eda8668f758ff7e7458cd838f967084d2fc632ee194f"
    sha256 big_sur:       "17fe40ae9143150f8b75674344dc29a8ec56bc356f9e6ae8fc96542d5dc1782f"
    sha256 catalina:      "9d29b013a4f80b4db9849bb7986bd844a4e3f047403e7340b38db71a76b610c8"
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
