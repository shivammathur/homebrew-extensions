# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/40439039c224bb8cdebd1b7b3d03b8cc11e7cce7.tar.gz"
  version "7.4.33"
  sha256 "f3406242ca682e9d694e9dea6ae5f7322134156089584fb1232269526650db4a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "6088093d24a1a9fd982aed44a9122b7fa72dccb10cca2c4d72c79ad58b3a6d45"
    sha256 cellar: :any,                 arm64_big_sur:  "9c041b77f95a51b4cebb5fe561dca62c6bf8cefbbbd7ebbe98677f046ba5f50f"
    sha256 cellar: :any,                 ventura:        "150448aacaf55776f1eee17a626f066b57c620d004ce7330f85e3c753944f4f1"
    sha256 cellar: :any,                 monterey:       "87725129e252b887a38df30b2db7deae750732d767f7e6dfe82dd3c935c67fe1"
    sha256 cellar: :any,                 big_sur:        "ab8ad81c438e7d72507ce796f15c1f6e930834f11bbe67b768e065fdd59867ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ad0499c824986174b1390258e31431e0fe15e6560ccfa4d980ee53316cdabcc"
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
