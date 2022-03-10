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
    rebuild 6
    sha256 cellar: :any,                 arm64_big_sur: "f0eab336b6ec4a0c5f65b50f5325f0f1b8fcb2995afff0ecf0df49ae63a80f81"
    sha256 cellar: :any,                 big_sur:       "4ee9cdaf852735f787d4162919bee5fe6f2d65bfb45ce0da9e5a5b48ee1275c8"
    sha256 cellar: :any,                 catalina:      "d94934f82d4c76d0955c60d9e5b453fb72523ce0a4f0b1a7a292b41b9f079e98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef4bc3a1230f0c8145972afd109c1b9f9a244c0b736a277f012aeadffe106c0c"
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
