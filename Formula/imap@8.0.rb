# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.11.tar.xz"
  sha256 "e3e5f764ae57b31eb65244a45512f0b22d7bef05f2052b23989c053901552e16"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "1dd5b2a24d6206c0ef322e4c9eee8a34f7a7d2031974facc8c815abf4f8612ed"
    sha256 cellar: :any, big_sur:       "a357a1e6454d8ffcdd6594c85c81f80e94eca25dc90ae5e1797c51545805c1ce"
    sha256 cellar: :any, catalina:      "424b7dac411adff94d2985f221145c9a16c2c971dfb69caa5bb7f61e93c6fecd"
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
