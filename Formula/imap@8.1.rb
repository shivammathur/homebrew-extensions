# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2d248c80b9f0cd2248ec68b32a05cee7d60e3c5b.tar.gz?commit=2d248c80b9f0cd2248ec68b32a05cee7d60e3c5b"
  version "8.1.0"
  sha256 "05c858859d8c4df5d421e220855d582601a93ba828e7bc2418ffe3b17753e3f6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any, arm64_big_sur: "aad97158bc5f275ea1d520d7ffedccfef06c99ebbcdaaf4784effe8a837554b9"
    sha256 cellar: :any, big_sur:       "9cb36006fa955be08242490d8fb799f3dbb3f62992de55a1e2cf687688ce9b9b"
    sha256 cellar: :any, catalina:      "dca7d0293477fd6ef8a157634794ddadc067f66f27eddc3f5d2eada95d624cf9"
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
