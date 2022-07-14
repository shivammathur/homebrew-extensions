# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/492f9c607a3e0ee258d1273fbc6d6da73f180e3c.tar.gz?commit=492f9c607a3e0ee258d1273fbc6d6da73f180e3c"
  version "8.2.0"
  sha256 "c5f4671519b9d0a9aa5d0af58664598ba1aabc2cf22475bc9df23814d16eab85"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 62
    sha256 cellar: :any,                 arm64_monterey: "99a7e579521837d6b01d40ac9061049f73cc060080cd29b8addeb2f0d84f07f9"
    sha256 cellar: :any,                 arm64_big_sur:  "7d195071a7244ab44d3b56c95eb3a857a8d154fde38357c07a5c24925f67db14"
    sha256 cellar: :any,                 monterey:       "6baa27ca5c1df21920c9d54c37d204c3b40089d836f22d3e73f549428f337d6a"
    sha256 cellar: :any,                 big_sur:        "55af03d90d2123d739895727fcbdc25be53aac6fb1b82f460dfe06099b66fe07"
    sha256 cellar: :any,                 catalina:       "052190dfb12cf264903d0ccfba22be860d83309601dd96271c54a3cad12e9b6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9c32fd86c9b128fa654527a5f9cace8b9b316544b4c3b1ecc0a987073901f3d"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

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
