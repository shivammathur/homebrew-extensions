# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e186765a4d129fe59d95b7041ab7c33e8c3e03ec.tar.gz?commit=e186765a4d129fe59d95b7041ab7c33e8c3e03ec"
  version "8.3.0"
  sha256 "0a4198c705ae1f7dd13211422b597c3f12ae1acbba8dd04a0c6004dada511e18"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4539fa0955f0ad328aea558265b353faba68f23bcd190d23816275e56058bd86"
    sha256 cellar: :any,                 arm64_big_sur:  "8a756d55904bfc2f2c1897e6fb00b5fb2b244a5aa3bac171f26e918dc7581c75"
    sha256 cellar: :any,                 monterey:       "e766f87e031b674e15b20bd1afe843f86f562a9cd7c9332dc2344f1800bb3514"
    sha256 cellar: :any,                 big_sur:        "81dbce6623e7e18a552a7c394c5a8a4a44b3f7875881d456f3ad7378b40ee7e2"
    sha256 cellar: :any,                 catalina:       "bdf03f5f24596fcffa2b8fbd430b1d58a24733a39298abbc31f7da23651a1080"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e34ab1fd064b9d5424371663fab9d4bb254d4b322343a161491127808bb3bb9e"
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
