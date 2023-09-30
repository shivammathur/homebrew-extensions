# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0b7a0e9f414cf40183a7ab53dacb8979e192350c.tar.gz?commit=0b7a0e9f414cf40183a7ab53dacb8979e192350c"
  version "8.4.0"
  sha256 "3baa53f8cece6cdce5b71b6d0c6427da8fcd5e6ae4729bc5ca60333e506f1fe6"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "b2211ef014999f0b39f6d0ebd11b613fb6c8683e89a045f96cd31edb2a6c2c4e"
    sha256 cellar: :any,                 arm64_monterey: "68f7d63896d4219e3cf43bd2f62f0219850b02c259f25c1b6cb53d7686b6dce3"
    sha256 cellar: :any,                 ventura:        "c34a343df286b6998ae9e695790f493e2d4576fe4ca9d4a09a1993ae3934842c"
    sha256 cellar: :any,                 monterey:       "f500886ea82706668205fa832809e886e1d1cae8b410b3422c90bfa4c8018292"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b19c8e6a036dc48f107a06e735dcc0fb77b2f90e6c198878d8576021935fadf0"
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
