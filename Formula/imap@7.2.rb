# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9441c5dbf3e4b7049f720742578bad9bd95a9571.tar.gz"
  version "7.2.34"
  sha256 "2e7b8049706e6d169729aafab091d98d0735767282ab44c275990418563bc160"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "022a53dd4bf3efb6d733b01e040d28db43df2ca90a8fe07246aeedcf9826467b"
    sha256 cellar: :any,                 arm64_big_sur:  "05853c06b649146f205d4c7acb41c9053ef7813104b1276b0f60b137cdef3581"
    sha256 cellar: :any,                 monterey:       "51b1f95628df922be851b868f1cad12af5f9ec3140e28f8622b52229401a523a"
    sha256 cellar: :any,                 big_sur:        "9f09cff6868c856268e6e663669630a9ca2e1de9f98745c62ea68e5a735dee3b"
    sha256 cellar: :any,                 catalina:       "24920ae8b99ab081a70e69a3fc285a04e606d41a52aa0a6ada2c724a46c34551"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b038ee7579f6ee23ab09a05f27680fee23555a7bc31841db39d58be9647e36d7"
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
