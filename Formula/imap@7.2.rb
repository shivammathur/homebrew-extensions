# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/68d7838b27f3612b97332f10e65847833c6461ca.tar.gz"
  version "7.2.34"
  sha256 "9079fdcae95ff11c52152ae5499a4b2f5933170a30b19083ad5b10fb35d6fa71"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_big_sur: "a47ec7cf25cc0bb20d06126d0f67ce486d4eca4c7ee927a29a7f7333d8b09ef2"
    sha256 cellar: :any,                 big_sur:       "d88f515546d844fb4ebe4ee53cc3b793236170e0667a57470b1253b9dcc9586c"
    sha256 cellar: :any,                 catalina:      "032825aa7ca8cb47edfae6c5a793ff2f6ec2eade79120a76daadc5a79aaa54e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46e54c1ca5679355c2290d9f485decea800d49c26537b98be33cb5c2edea8b20"
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
