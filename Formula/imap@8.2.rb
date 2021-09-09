# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f983373e44dd45c7e09036fc67476fc946306b3c.tar.gz?commit=f983373e44dd45c7e09036fc67476fc946306b3c"
  version "8.2.0"
  sha256 "c34a7f66cc7d081448883dbc63d1d8b9040a56d445191337c8219a0ef2399010"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "647c4dd125d8d893eb06dcbb5d85b50c83f7e56e6be5e0689a5527b006ff70d7"
    sha256 cellar: :any, big_sur:       "2303ceee0d0c92e51bb2c89030345043162b9127c624eab549293b4070bd20fd"
    sha256 cellar: :any, catalina:      "e80f307408e57fab341552df1ae91129d291f02cf77df4d96d5d145e7d4918ab"
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
