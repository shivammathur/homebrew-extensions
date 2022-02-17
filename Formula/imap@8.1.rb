# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.3.tar.xz"
  sha256 "5d65a11071b47669c17452fb336c290b67c101efb745c1dbe7525b5caf546ec6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "860fb3887099f5bc239d392cf279f4b183027cfdace70157bf12e866a83c392f"
    sha256 cellar: :any,                 big_sur:       "2b0762ee4af99747ddfe5bb52ae67fa6d1e82de8d771d5eac695a710150410c5"
    sha256 cellar: :any,                 catalina:      "97be88d8e69d153190c1103f63ecd2aba51de79bdaf1e393c650d97ad980a153"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eaffdbb4b8d058f3c939aa52f001c2a04c0cae74b21c62d97ae9c5cf3029d044"
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
