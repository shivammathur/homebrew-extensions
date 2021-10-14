# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d98634e652b99cb4c6b27e286b97f506370d85aa.tar.gz?commit=d98634e652b99cb4c6b27e286b97f506370d85aa"
  version "8.1.0"
  sha256 "2ced116a4d25bb9533376eac05ff2eee6f9a409f48ea17d7a74b0ad00e3e0bed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 29
    sha256 cellar: :any, arm64_big_sur: "1b734c347b7cdd468bae7c944075a1c31082a8686c9841496fd31245df620645"
    sha256 cellar: :any, big_sur:       "059e445a5b189dba79670a7873dae72a848db303b79ec1f91fa47c0b184e39af"
    sha256 cellar: :any, catalina:      "c0c3c737cb3359a4286dd1db1abd916044055712dcd1616feb8505be3475c7db"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
