# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cb5d5d885cea40caa6220d251a05da35b9faa565.tar.gz?commit=cb5d5d885cea40caa6220d251a05da35b9faa565"
  version "8.2.0"
  sha256 "f7a3d4aef1488999fe06e2ddac5d0421392f6a59ce5ffccd451bc663d7b2d976"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 68
    sha256 cellar: :any,                 arm64_monterey: "9a8d126f6e5f51a7f53fda8c34d71e8fb9795bf8762bb230084a3db6746f6667"
    sha256 cellar: :any,                 arm64_big_sur:  "347284472ad29e734030d2595495c3ba59596bb122cb33ba8a2e2ebf51966c4c"
    sha256 cellar: :any,                 monterey:       "196d6ea9f70828a79159e056523cc021b61ddd7db63169c9092489a4ac5efc9e"
    sha256 cellar: :any,                 big_sur:        "9ec30fd255a295807218b58b69f7949122478f2f87b30c9d4512132b2ead141e"
    sha256 cellar: :any,                 catalina:       "59a01dec082b237100f21a059a8a850fcb65681be39ffb09a8d41d9120b3ad76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9652d5bf108ba8f9424f6f045db5090d5a587280bd3d933b3f3266c863b6d417"
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
