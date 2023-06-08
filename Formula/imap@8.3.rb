# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ca1905116bb25ffda5509078563f673644a1656d.tar.gz?commit=ca1905116bb25ffda5509078563f673644a1656d"
  version "8.3.0"
  sha256 "4acfeda438eb527da8d5ce6716822dd099182bbb55c85c3760a664dca7a0b0f1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 39
    sha256 cellar: :any,                 arm64_monterey: "cfbc46a190660132e576f1f6590718d32a51f13c2dfb9d407257489c7099d3f1"
    sha256 cellar: :any,                 arm64_big_sur:  "89de08f4455645fbcf5e6c18f86eb2073aa69554643f3e2fef1a81c4b99e998e"
    sha256 cellar: :any,                 ventura:        "769eee90f4c35f1f127706d1a7d3b04bcd604d367422f7e6a19e7467bb9c10b9"
    sha256 cellar: :any,                 monterey:       "6a46aba8cac661ef67ba826fd3711e7e3469145e48d72084b9a375e2cf30d7d6"
    sha256 cellar: :any,                 big_sur:        "f21954b51001a72050cdcedefcf836c2bc561317dcb0d1cea65a0ba40f7abd27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83919ff1062a37154cfa668647a1a85ca70f9936102ad995834580c7b6464675"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
