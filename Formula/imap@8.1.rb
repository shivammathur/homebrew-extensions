# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/67131e453b1341f9e704b627e25876935b52cf10.tar.gz?commit=67131e453b1341f9e704b627e25876935b52cf10"
  version "8.1.0"
  sha256 "6644c768f2bc4a2428a074e916f69f972054e8db175ed6532ebd1559d3f845c5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any, arm64_big_sur: "6e57733dedeee2873ea632d56e2a789500e94e0472c91085cba384eea4cc4785"
    sha256 cellar: :any, big_sur:       "8ceb0a9ca434a5ffb77602b5f1e3527fbef32b0e69092294d382aa393f9e7458"
    sha256 cellar: :any, catalina:      "b4b8403bc221b6924b1ddc8d6e51698bbed80f8c1935ef0351a54424426f20ec"
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
