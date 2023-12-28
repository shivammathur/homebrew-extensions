# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/90d58fc0f49b4a777caa489d59ff7b6b6620ba04.tar.gz"
  version "7.4.33"
  sha256 "65f5056dfacd4fe03f0642cee9e5a7c31b6710679f661b24e0497a4cd46c3b6c"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "a0c10e972a61066ed7427683acc697454f444a94cc67af3fac5f8ca5287c82cd"
    sha256 cellar: :any,                 arm64_monterey: "755d9c4d3870b846cf5a9e68dede786271b2b0aa95ee87af4a8c1f968e352cc2"
    sha256 cellar: :any,                 arm64_big_sur:  "9414529a83f372f88855fd011d358dfa87cdab37c033dd22ec46bf8cd168b0f0"
    sha256 cellar: :any,                 ventura:        "6552000ed8b2bd8acf9c0a71ceacf3c9dc2666793f75b37d33f491314e2e1915"
    sha256 cellar: :any,                 monterey:       "4c56c88e59dd3050eed3118149fb6188c9023cfb7d83644b5bea5def8dca2bde"
    sha256 cellar: :any,                 big_sur:        "2646cb67332eb906b1d212ff013db50c6697eb70e00079dbcf31c163d8fc5a6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "106f799669ec1e940a8d717012b0ce5b719e86bced45453f7d66dd27cbcc5e18"
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
