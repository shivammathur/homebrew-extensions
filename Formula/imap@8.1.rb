# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.4.tar.xz"
  sha256 "05a8c0ac30008154fb38a305560543fc172ba79fb957084a99b8d3b10d5bdb4b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "e617c12a18c3057d366b27caaa2ee4cdcf05be22d6281c085b419986e3084196"
    sha256 cellar: :any,                 big_sur:       "de0d316a4e2dc163b5af564bb739b9db125e1390c0552d49e6e93348e10140ff"
    sha256 cellar: :any,                 catalina:      "ae596fa1c5e10b2ad8e676b86908fa9a69e76510ca2fdd73ff3372a1703de051"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44923815c3c6061535031c89862c5d2ec57f0cfcd2675913cf8ee5079891b243"
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
