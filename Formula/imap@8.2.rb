# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/37dbad87f39074b52ab94267641ca3a6374b26b9.tar.gz?commit=37dbad87f39074b52ab94267641ca3a6374b26b9"
  version "8.2.0"
  sha256 "fcdc75089caf8dc95c164826fc8472f23e71f199b1b3072931291e7996906430"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any, arm64_big_sur: "2c2f10797437dc9c16ffb75cd2143cb4f343aef88166833e90a7b984e6ff70c0"
    sha256 cellar: :any, big_sur:       "9894bfc87edd6a215133cc086bc28ca144528fb49c52f01a68a1af3150a19650"
    sha256 cellar: :any, catalina:      "bfc4ee7a560001f2f73b36308134f510a1084f7a51ec30829bb0faa87cd663a6"
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
