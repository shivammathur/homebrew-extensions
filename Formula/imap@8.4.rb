# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3f82da0a4e043d19d451abc2f26674eeaa111665.tar.gz?commit=3f82da0a4e043d19d451abc2f26674eeaa111665"
  version "8.4.0"
  sha256 "6d92fd808e76d321c7d01a7e0b613f65dd3a14025272034bfc806d4c2908f5d0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sonoma:   "168c18b2487a71f30e8ab6b3cdaae8706b272df0f9cf313bb5047eaefadcbbb1"
    sha256 cellar: :any,                 arm64_ventura:  "56fdaa365c5dc0463254053a0f3953a853982132bba5b425a1319783a3267817"
    sha256 cellar: :any,                 arm64_monterey: "aa6132ac836d152d43a1369163a5292db28229ae34fe90b2ac7950a70b32f5fa"
    sha256 cellar: :any,                 ventura:        "274255e416d36862ef0bda6fca6e468598e7421fdfd99d38da96156057a6b03c"
    sha256 cellar: :any,                 monterey:       "5c9f5ff97784d7af8498004ecc8b2ad164a37209d1d0e84104341020f82c02e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c0ed7cecb41b1c517ec7332b2dbd9afb319fb59760a71c7c6bd6745a92e413a5"
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
