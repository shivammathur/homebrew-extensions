# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/354c52e9b6d8d440144ff412157df80b73cd4cdd.tar.gz?commit=354c52e9b6d8d440144ff412157df80b73cd4cdd"
  version "8.2.0"
  sha256 "433ac135bc86c5059f65abf150d7153760b08b9380dca63e8a8f4ef06e5b5311"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 33
    sha256 cellar: :any,                 arm64_big_sur: "5d808a7b08f7818c9dcb7926073d511401d770132f712d0f075717b06b358c06"
    sha256 cellar: :any,                 big_sur:       "01ed3295c865882dd1b7cbbd8f5ed69773943c761fc9366327abffda54e1dd21"
    sha256 cellar: :any,                 catalina:      "3a019efe906a86f4f006c05c4957d9fa5a3fedfb5d54abdc0be15c75b269c160"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c369f2d53047436f12ad74c3267becd0ff320f2703e411ae42d12ee374eb8378"
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
