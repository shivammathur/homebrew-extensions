# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b48fe144e27084b7c66c6921d2eed205b1ccca8c.tar.gz?commit=b48fe144e27084b7c66c6921d2eed205b1ccca8c"
  version "8.2.0"
  sha256 "2fd050e44176b189f76ca46404c0ac58bb1993be462a7ed6484ef5261cd122fc"
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
