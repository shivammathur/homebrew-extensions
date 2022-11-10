# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.33.tar.xz"
  sha256 "924846abf93bc613815c55dd3f5809377813ac62a9ec4eb3778675b82a27b927"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "809e35f34ba71ce5d645bf3f1b6b641cd0c0e52faafa6fff881cf4feb01d8efb"
    sha256 cellar: :any,                 arm64_big_sur:  "7a41d968504ebaf8a800cde88ee47b5a96e6c92030ae986100f5ebf2c6ce77f6"
    sha256 cellar: :any,                 monterey:       "66132434b1a5a2c3b90a518a609e54c33cd02b62719bb15b71524424f1b94a02"
    sha256 cellar: :any,                 big_sur:        "031b2b14a09789446cebb71e35f5a6db9cb5f2eb69ec208be7da14d00ddc8345"
    sha256 cellar: :any,                 catalina:       "7532789f80dca17fcd04a7603c96336b854a8da8c1bd4b350bcb2dc6bbda86d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "de10f8ab95babd913df2220ba70c512fad5e1463cb9beefa0b3d2af7fa6622b7"
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
