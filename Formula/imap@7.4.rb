# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.26.tar.xz"
  sha256 "e305b3aafdc85fa73a81c53d3ce30578bc94d1633ec376add193a1e85e0f0ef8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "aaefce1d25bdbaf30e65ea6dae554d55ce3d173a3e5d191e281642de03cb3c08"
    sha256 cellar: :any,                 big_sur:       "cbd7bcfe3ee1a0bd1c245c6fe1b5f39b309218255a56deba5a8b2cf3a2938758"
    sha256 cellar: :any,                 catalina:      "d4dba3421abb16fda5588a812b121a6f2dacabd86abe0d211d5e7807b0242759"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3826f326f31c91731c317f1643f4576b01f6e9afa5f602c3e3e848e713a4852"
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
