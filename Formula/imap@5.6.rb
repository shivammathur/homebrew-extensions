# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5.6.40.tar.gz?commit=6ce247eabab1cd3ec4df4510016ac440bc0bbce2"
  sha256 "1d0272361a5f33071e81ae09ef1447e74cd40be233e128118e51ac9a076d68a6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "eddf4ca210dbc7a7c984cda44ab5abf824a586f5f6cf3ccd3c0d10040a786460"
    sha256 cellar: :any, big_sur:       "d98a8b1795f4820866769407d14bce12bec5c682fc2930b07efc24ab1a303c8e"
    sha256 cellar: :any, catalina:      "e789a425971b8b0036ab1972b87ea93f568b201b6a87ed3b62aa208d24a6c53a"
  end

  depends_on "openssl@1.1"
  depends_on "krb5"  depends_on "shivammathur/extensions/imap-uw"

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
