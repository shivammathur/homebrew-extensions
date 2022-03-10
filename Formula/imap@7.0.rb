# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/37dee36f6593bd700523566d56fd317e4fcd6156.tar.gz"
  version "7.0.33"
  sha256 "3d7ee005c8d21ceacf5404ecb39bb64e45277f8a4cfd3f47087bbf2ce765eb69"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_big_sur: "ca0ad33fc1d4e03b5949060cf39ea52eba46fef0483bf105578ce2a6a442b6b8"
    sha256 cellar: :any,                 big_sur:       "e5d8607d96059d203214d394054bfed1bf661382f2922c9dc43240a133063e8d"
    sha256 cellar: :any,                 catalina:      "d6ce3696ce17a102b624d2fc8d9e5481347000be2aba65ac22cd9e941e42d664"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "245c164321095ac1c7e7ebf83484432f55a676887fe1e037137c27f7bf1a7077"
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
