# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.8.tar.xz"
  sha256 "aea358b56186f943c2bbd350c9005b9359133d47e954cfc561385319ae5bb8d7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f71b440583baae83c1d3c020b9c4ebc18cb1b16751b58f9d87ae62f4bdcad8ff"
    sha256 cellar: :any,                 arm64_ventura:  "00486a52aa47242387820cd73688ba7ae0501ea550cb14265949d6285143cdc0"
    sha256 cellar: :any,                 arm64_monterey: "1505301b684ec9fb9fdc6c242aa865a4f993d4892358e9f101b5d28547f3899e"
    sha256 cellar: :any,                 ventura:        "06730166df0b92c2e82dc202599a450387ae897e71adb3a73364b0afb6283cff"
    sha256 cellar: :any,                 monterey:       "2b8ec6dd8e4caae8f63c6c0b1ee07fba0078eef657e61f62828bb3c30d0fe4a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5cf3d435d8670f3ebb834d92f45ac1824ba25c2cfc9f1391c2985a58bb919c11"
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
