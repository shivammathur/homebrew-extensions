# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.15.tar.xz"
  sha256 "5f33544061d37d805a2a9ce791f081ef08a7155bd7ba2362e69bba2d06b0f8b2"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "2430438d7c25a9a0c56a0d97154a8d38e2786a6db71bd7e5e9c85261aa518367"
    sha256 cellar: :any,                 big_sur:       "495c4bcbc7cb0520ee83d001c387c0b636eb9b65505a9ee1f40fd3f03d8176f6"
    sha256 cellar: :any,                 catalina:      "3c6782b6d4c49e970098d9db5e2ef12f32ab40ec457249a270ebfc3d7758bcda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8ab5c734d427c08c1ee673b2c9fd75c51e0f5ed4cbaf0b04eba0adb9d362f07"
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
