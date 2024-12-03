# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.26.tar.xz"
  sha256 "54747400cb4874288ad41a785e6147e2ff546cceeeb55c23c00c771ac125c6ef"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9d70d4be3d655e5ecb2d63b3edc7e1fd22b5c0aa5e01c8386416ad2dd8bf030c"
    sha256 cellar: :any,                 arm64_sonoma:  "cb949f41c695b40da0e223da07b92d6d66b90392abf7beccfe009f1982a3e6ab"
    sha256 cellar: :any,                 arm64_ventura: "8b81b63b002a4b6bf6f50d2c15c659ddf26bb68cc05d9916f3881b3d73286a05"
    sha256 cellar: :any,                 ventura:       "fd1674411dc27a9076c65fcce556dceca7c144903d46a2b0a04d8aeb015196f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8dfaf1c6d292910d4d1f30ed219628d54809c5fefacf3b034d34ef61746db43"
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
