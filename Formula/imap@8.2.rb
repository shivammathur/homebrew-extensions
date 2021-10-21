# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9962aa9774087e8968323f84e16314137b8cd25d.tar.gz?commit=9962aa9774087e8968323f84e16314137b8cd25d"
  version "8.2.0"
  sha256 "102946b86fc677bd5767b5bcfa2a1886186eea9c904091d22f2c0ec5d1ebb597"
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
