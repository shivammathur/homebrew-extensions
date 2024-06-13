# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.20.tar.xz"
  sha256 "4474cc430febef6de7be958f2c37253e5524d5c5331a7e1765cd2d2234881e50"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "cdfcbeff4d59a6ac1842672d4661e4e303c196ee7426f0d01f306e6e643b7ce5"
    sha256 cellar: :any,                 arm64_ventura:  "734199927f65589c146b62fd89070ce6f5ee4baf7d1cb97de3c2c0691846143d"
    sha256 cellar: :any,                 arm64_monterey: "d9368fb523dbf7d22026c9cbdc89765a7b6d84c39c442b821b93595e8228a59f"
    sha256 cellar: :any,                 ventura:        "1dec5a30e6033817a0859047349dc4137d3ae31708a458fa3c776ef892f61e79"
    sha256 cellar: :any,                 monterey:       "21838a9eafd361cfc30b2cbb7df916e66cbbb499f86b10b034117ef4dc905874"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "137426b80941b5d74e2b1a37576453a5cba4a7648882dce4a5d15e30ee096135"
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
