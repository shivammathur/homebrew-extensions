# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/06de112d327ec10419890ce2d4af7b78eb106073.tar.gz?commit=06de112d327ec10419890ce2d4af7b78eb106073"
  version "8.2.0"
  sha256 "fda66fc3fbd1df864591cfdbc403cdc7e3bf219973e5d0fddaf472986eda858b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 34
    sha256 cellar: :any,                 arm64_big_sur: "fd0669e0683fd8abf4084f6d9080473076adb0c8c3c4ae23270a8747883ac2d6"
    sha256 cellar: :any,                 big_sur:       "a05fd0f155f90f7071c9d9dfdd9d7f570acec586663efdacfce88ec64222cf2c"
    sha256 cellar: :any,                 catalina:      "b2564ee144c53e287a63e202c9adc6697860d8cc56a18688909d9671b5174aa7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ecacc671d38fb6329afef0056f38b728efba79de05b8b478f71f907a44b0fac6"
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
