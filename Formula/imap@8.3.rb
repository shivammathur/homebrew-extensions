# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7c5a57077ab6cd48eb274ca54f130e2eab3e028d.tar.gz?commit=7c5a57077ab6cd48eb274ca54f130e2eab3e028d"
  version "8.3.0"
  sha256 "4ab7442af6e8a9d0d9b38087c0ac66fc627f86e890b0659e3ef1d4e7aabdcc65"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 43
    sha256 cellar: :any,                 arm64_monterey: "10082064138303e1d6d84ccb5d5c63e545632c7206037577982ec9bc6f6a92f1"
    sha256 cellar: :any,                 arm64_big_sur:  "ff72f150307f46ebdf2f5c1715fb7ad9c911259eb21ffab992c869a7cad9e1ee"
    sha256 cellar: :any,                 ventura:        "bb63d9a6699d614b82e4da39cd1d82d54f3756abe8f77c43b4a71efd38f4f0f4"
    sha256 cellar: :any,                 monterey:       "92f3ef448c9e0b13be06db09df1594c8759406e1329594bb3a0a7b1b2012199e"
    sha256 cellar: :any,                 big_sur:        "e4037936c5da1afdf43e2a53b4f7dbd78ac885112fd84dd051351604a02ed3fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c36055b2e456cef9e9c3e5e13722a4e5647a32d32667746eb760358ae0d140fc"
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
