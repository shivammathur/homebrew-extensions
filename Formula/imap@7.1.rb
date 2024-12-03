# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5333599573a621aca2d7555117f115e30b2f7c0a.tar.gz"
  version "7.1.33"
  sha256 "427832fcc52d9f81d7a22aff4c6fdbc18e295a4af16b4d4bac81f044204e6649"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "bddafc0e3ec450b5ddafbdced2f5dd4145448a103a80e94f3e0e01d28b8af073"
    sha256 cellar: :any,                 arm64_sonoma:   "c09c72b8da19ea5293635ddc6cc679f1662508cd9e95d4c667d3628c54362113"
    sha256 cellar: :any,                 arm64_ventura:  "c9e7dd8b7d3dc5ce3b04cb38e8b1ebe4d7ad259468061ac5b67d3ec280be8267"
    sha256 cellar: :any,                 arm64_monterey: "1d1d5f9837dadf70c419e595aea90f1785889c57e81a9a9f252e0f344a2d7bda"
    sha256 cellar: :any,                 ventura:        "a151bea63024d8d99cbbc678d62d18b0a2135788680b808adc7d14815c848ff5"
    sha256 cellar: :any,                 monterey:       "6c97e9e5f84cfa771d6fc8911098bcfbdf9e935c3675bb3e3e5bed1f1cba592d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b19096a19bf06a51c96e922852fd86c36799ba7d02570fa58e00d223da0392e"
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
