# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/78364ef97ed46c585a31c601f4e8f8330d5a95c5.tar.gz?commit=78364ef97ed46c585a31c601f4e8f8330d5a95c5"
  version "8.4.0"
  sha256 "64a37e6855b48af40f8518ddd69cd22d5a32a43dbcce7668ca45606cd29037bb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sonoma:   "19b63719e1a35b8a82970cb393b657c929439f47a4a2c751c3b7072847665a82"
    sha256 cellar: :any,                 arm64_ventura:  "3f47391751aa6f717a9e0fcf696646aedd6718cc2111cbfbaac4eceddf649a33"
    sha256 cellar: :any,                 arm64_monterey: "a61d41058affcffbef80e87949d1dd14d87069836959557f2b3fccb9d808fa73"
    sha256 cellar: :any,                 ventura:        "cccff38f48812ffd15170f3f9124be41fd7572ccac04698bc93ef16b6a20aee8"
    sha256 cellar: :any,                 monterey:       "7b182afd9dd9fa843e134fac6293badd734dbdb4af62c807a5b22ae265c3f0c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a4b43f86230899ee4c4b7e669d36d89959a63930d72a9834f0cc064fdba82f4a"
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
