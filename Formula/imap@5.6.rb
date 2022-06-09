# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/ebb82d7337885ac0d4346a943e336e9784d3af55.tar.gz"
  version "5.6.40"
  sha256 "9d556c089a7cde5341744691920b482dc90013a8420973822235a5758502f797"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_big_sur: "4f4c5ae5b1e3e888c7fd5c06935a6251a96a80ce85f66c61627990190f677f0c"
    sha256 cellar: :any,                 big_sur:       "758173c528c2e40ddef43dcfdb2fc67b239b2ad2bde544a34866996e9d58fcc7"
    sha256 cellar: :any,                 catalina:      "18cc3a2511bd5a9c7e0fdb3dfc153b000b8274ba6d3bca320fb4a1aed680c313"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ef57572a5e5d0b4cbabb3500e8c01d99dac9d4ebc72ff4bd367e4565d6c25c4"
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
