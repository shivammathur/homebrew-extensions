# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/cbdcb0e46f73b1e1ab1b7dc3fb2383efbcc841a2.tar.gz?commit=cbdcb0e46f73b1e1ab1b7dc3fb2383efbcc841a2"
  version "8.2.0"
  sha256 "66ab71bc9916b4a2626f22e0e3c376bb9915b54cc9947a048375c033a8b74315"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any, arm64_big_sur: "a4d121a08a1af92165e0a076ebd36198e76853c5707a58d1ea747b0041b437de"
    sha256 cellar: :any, big_sur:       "c9776833f92aaf36fa61cc28c1aedbfb184c5caaa29eb5d762f48a40717f8a39"
    sha256 cellar: :any, catalina:      "81ee75ddda5a4b34c73da222dd55d401071aba83b86ac533997703b48d088be5"
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
