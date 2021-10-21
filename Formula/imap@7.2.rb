# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz?commit=7a5fd67bd0d072fe4b5f072fc91a95c4acb48893"
  sha256 "a6aac9c7631d548b7311f0872b7a9a79127792966f25bf3e61ed2e68a8a8b51a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "a9b9af311980a6a648e1f57488da0032854fcb287374a1e1eb06717cde204b3f"
    sha256 cellar: :any, big_sur:       "ed1b1af583d0abe3e06640c379ebc5e43d58aebb7541629d52683345947464de"
    sha256 cellar: :any, catalina:      "f4daab8419afc71601a1597aad50a9395695f8c4c635f17be8fcf6bc48fef926"
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
