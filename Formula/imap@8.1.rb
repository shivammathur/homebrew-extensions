# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.16.tar.xz"
  sha256 "7108b7347981ad6e610aaf3b3fb0f6444019ab6f59a872c1b55a29bc753eba93"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0816493614b0c0edb79584369293d2fe41496e234caba46bab6214da4870afd0"
    sha256 cellar: :any,                 arm64_big_sur:  "8b69cf8575334fb57d1df1dc0be8025ac49ae3e96981d8d1d6af81a88d2f3ec9"
    sha256 cellar: :any,                 monterey:       "8d048575860f8a7f2100aa1c18cf8251515681da69ba659c45168c12a405df94"
    sha256 cellar: :any,                 big_sur:        "caa42017417a8437b97577fafbcc96085cbb43b570368f2f71c3816affe65fa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aff8bbafee4653b8a2d95517cbfaf5ca27c3f9ba728102f4ff166d08985a825c"
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
