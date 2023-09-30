# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6a2b8851556071a5cefa1297e1a88bebc4753081.tar.gz?commit=6a2b8851556071a5cefa1297e1a88bebc4753081"
  version "8.3.0"
  sha256 "ed39bef1ddcd0bebf36924ed69a01d062f5b915346f9e06258c97fb82c257c5d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "c727fc3055475236d3f16a268553f09c96eb8b76bbf8c2b58298d340a2cfc68d"
    sha256 cellar: :any,                 arm64_ventura:  "5547887ea5fa7f5405eae89b73684be3089d183601f3c413a5923feac105f3b0"
    sha256 cellar: :any,                 arm64_monterey: "fad07095a23053a8162a94e71ce112bff4b8edfc670a9379c74651e8906c0aec"
    sha256 cellar: :any,                 ventura:        "2187f8a0d3c16f66e17844898d17713b8601150d51a1cb47a99fd71af29a16c4"
    sha256 cellar: :any,                 monterey:       "1153d479adb3853458e61bac06612f6c5bfc0c4b3a5f565729834f8a3ff79b4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0bba2e0ad2a9455ea619c5a625d31619e98cb57f98c8b68115744ecc2e0c893"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
