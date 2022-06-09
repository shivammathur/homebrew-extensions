# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.30.tar.xz"
  sha256 "ea72a34f32c67e79ac2da7dfe96177f3c451c3eefae5810ba13312ed398ba70d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "964add8a9a4211ccc9806a9c829ce9ae4be5db893624926c8c84cfab32aa4725"
    sha256 cellar: :any,                 arm64_big_sur:  "04f845bea0c6b0741bf0d448f1b38bb2ae2573b1040b5f2b0512334e4735322c"
    sha256 cellar: :any,                 monterey:       "9c27c9be804ef44fdd80fa591b867bc6673e5e5ac3440cf9b29f7cb1e1c3fa62"
    sha256 cellar: :any,                 big_sur:        "9f6f624e5d740f14e54186f686ad222b707efe921f4839b17c5c148789f41146"
    sha256 cellar: :any,                 catalina:       "30909750e532f19a186e70212c2f53eb484f1a164ba3d919f8db39c200cc7ea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aacfe36bb1f8d39896d9f7b3d1419e17221f0c6f9e86676b728a9658dc3d6008"
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
