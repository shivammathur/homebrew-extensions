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
    rebuild 28
    sha256 cellar: :any, arm64_big_sur: "d8f07f902ea110988b9bedd6fb24a78264494d8dba4734c9702f3c55dd5bd62d"
    sha256 cellar: :any, big_sur:       "0731fe3dd5edb3de344317a2b6b20423f9bc1383c70635a415239f39f6cdd899"
    sha256 cellar: :any, catalina:      "1dcba971efd974c561aab1975f6c05fe7c0291b1c96c5f8e42375d08ebdfb72f"
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
