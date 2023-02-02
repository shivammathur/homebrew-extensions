# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c66513169aedfd0903381e149e65c5ccc6ae32eb.tar.gz"
  version "7.3.33"
  sha256 "64967f24896e28043cc615a8ea9e1ff0228a4169fc50bab6d42788c2b160240c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "2b06dfb303e828c36f6fe979b70b27a2bd73f0ed533e667c846d1f50b386d107"
    sha256 cellar: :any,                 arm64_big_sur:  "ecb31f26d4f2c2adaa5c29edf1dcf5aadf6ab387f8eeb608c3f85357119d5afc"
    sha256 cellar: :any,                 monterey:       "d43f9c42a07b1d5aaed24b8d810829c20ebecef6d7bd70aafc378f42bf9114a3"
    sha256 cellar: :any,                 big_sur:        "1234d6666e431da8076de1fbdfa737115cc1f6a473e4128f624eb79e33ba466f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7af6f6d7743a75697e4ba0a00f843ffa6086a1043fe6f4da82e8a3a981928d49"
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
