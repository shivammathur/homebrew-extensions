# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b9413f1c99872b744c15f807e811fd280842ed28.tar.gz"
  version "7.3.33"
  sha256 "d46f032f9253f219cafdf5d52c274bc52cca2b6af9c799fa71cdcdd7c077b298"
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
