# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.10.tar.xz"
  sha256 "561dc4acd5386e47f25be76f2c8df6ae854756469159248313bcf276e282fbb3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "b0788cbe9c6ca899d386d961e5fea21d47058a3fd8235bd8f278a3e157e9a937"
    sha256 cellar: :any,                 arm64_monterey: "fe6a70ce45aa4344b22b1bacd0c103e942bebe47436304dd41c0ff02df118948"
    sha256 cellar: :any,                 arm64_big_sur:  "4e1c34df0a0e7aab011871de86583285159c42d2ef4e8c8623911b3efbfd9975"
    sha256 cellar: :any,                 ventura:        "4ffb2265eb75a4bc0a8bafed64ca6cbcf67b88a26412ca6a4bdce3d26f8a3ed5"
    sha256 cellar: :any,                 monterey:       "e8babdb0b0720c39197d34bcfbcb3cf6e2f6db75c50c8f9dd061cd496b5356f3"
    sha256 cellar: :any,                 big_sur:        "2147e1e84a210e0ae8b195d969ebd4439de75d37ab9139eee2364f54943e9a6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2626b3f453427a03c6aa1901ee6270f09acb53ac1687ba27919c4d808a58fda3"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
