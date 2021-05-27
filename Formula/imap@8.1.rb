# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?commit=b9f3f35d4a4e48f7461d19d1c1f12d00127ef259"
  version "8.1.0"
  sha256 "15591389e5079a57b7139579d5d581a18e50f9cd56abd87255ada1d665479a76"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_big_sur: "e9bb7016be9f43aeb3f82c62cf947d8dc1b4d3d3217dd8ad708ffa3c224cfe1b"
    sha256 big_sur:       "47c585bf36a0d46b219e909930891e6da1eb65c704495fd3b0178cbda669a3ea"
    sha256 catalina:      "3f12f4b63d942d072dd37f546e68df18a5e94191293aba8181a3d5e8a8046cb9"
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
