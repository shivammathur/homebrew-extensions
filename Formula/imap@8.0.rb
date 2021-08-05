# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.9.tar.xz"
  sha256 "71a01b2b56544e20e28696ad5b366e431a0984eaa39aa5e35426a4843e172010"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "3afe0957196a62c4535bce5b84fb95ab57af7114bc6ddcf65a839221223a244f"
    sha256 cellar: :any, big_sur:       "ddb9928895609718408c02966640bef2c2153376c112113ed26bdb864b77490d"
    sha256 cellar: :any, catalina:      "122b87d5cc35425b81fa1a5bbeee51770ffd7c8e3871e3a86766066c6ea49991"
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
