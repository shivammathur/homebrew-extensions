# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhp81Extension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/master.tar.gz?v=8.1.0&build_time=1611484685"
  version "8.1.0"
  sha256 "8a31a0c134e0131351ee62982592af4071b920871ce35d7cd3c93cc4e662ea11"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 21
    sha256 "386f34de927f91abd2c9a2f04970cc88b3e52ac183104b43bbbe17ec1a56e724" => :big_sur
    sha256 "a2d3e602a44af470699f3f1fb2c1af4677fd85b6ad8dd27f9a24ca47dc2542a5" => :arm64_big_sur
    sha256 "757e843aa2c1cd85b4f3fb88e2413f7342c8866c76f5a96e096be18b74e9255c" => :catalina
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
    prefix.install "modules/imap.so"
    write_config_file
  end
end
