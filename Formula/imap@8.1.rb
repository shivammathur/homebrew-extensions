# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a2bc57e0e531367f40fc50aa935bffac60cd61e8.tar.gz?commit=a2bc57e0e531367f40fc50aa935bffac60cd61e8"
  version "8.1.0"
  sha256 "4410bae79c0505999af08eb79e2701955280f51bd8ec1bf242880d5bbad58a80"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 30
    sha256 cellar: :any, arm64_big_sur: "110af4aed6eac6595e0909e2b2e7d0a5538df07f5a734c4fe43ac29b0303f936"
    sha256 cellar: :any, big_sur:       "81908cbc4d43fb9d0949fa665668b213059f81aac77f2faf706f7a6578de21fe"
    sha256 cellar: :any, catalina:      "9fccfc3559fc31f735b69b9d3b60b2af4f0fd879b38b9f3e068fec1385671480"
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
