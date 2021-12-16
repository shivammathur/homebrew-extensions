# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.14.tar.xz"
  sha256 "fbde8247ac200e4de73449d9fefc8b495d323b5be9c10cdb645fb431c91156e3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8eb6a2ef2212186c76d32c4eee48ea9b98fa14f56335fb212a3c8a8587a66c3d"
    sha256 cellar: :any,                 big_sur:       "35083d74fcb0b7585255f3c3e6e94794339214cc0c956262ea18c714343a35e8"
    sha256 cellar: :any,                 catalina:      "36ff533d7ab556cfc2542b20c048f4db7d0bb04e168055facc6fdd223d6b3912"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18430268176d274a76dd5f741887fd3db516991b4cd49b5866082b8232b59e35"
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
