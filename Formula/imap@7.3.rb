# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.3.33.tar.xz"
  sha256 "166eaccde933381da9516a2b70ad0f447d7cec4b603d07b9a916032b215b90cc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "e63dbb10beb645415ea85f8f0f5f49cce947c290d445ad64679546896ff26f69"
    sha256 cellar: :any,                 big_sur:       "4900f8028b8039e7d1ced07dc7b1a93dbd9805504b6a0919eddf6744d5a77b94"
    sha256 cellar: :any,                 catalina:      "64600753fbbd38ce41ab655ad9a7db20ca924c7e7c3e67bee73755c84f96ab03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd36160a5aeca37ef253ddd932069704c5b1d0c03737643f26da3bce4853d13c"
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
