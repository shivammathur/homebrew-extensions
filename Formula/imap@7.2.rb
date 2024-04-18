# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/fd96daa9aae7a1c43be03fb261bc54f6d3692e06.tar.gz"
  version "7.2.34"
  sha256 "9428386bdcfc4b3e64360dcd906368ec457a909775913605d8f6514c3ae5b291"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "faa2ab84487cd247371102c89f4b620f0fc8fb483004ac4a12a059878f6a9189"
    sha256 cellar: :any,                 arm64_ventura:  "55dbd70aa133a0bd1448bf0e13a85e2c63d0f2f3b56c924f44991e9420b1690e"
    sha256 cellar: :any,                 arm64_monterey: "f788a2d831ff906ad9ad2bd50a0f663eefbb75e31459f9f4c1e40bacf3eaf291"
    sha256 cellar: :any,                 ventura:        "a432ec650448dbe44039053edf20493c95bb790915370daca77a3433939434ca"
    sha256 cellar: :any,                 monterey:       "4a02f9dfc703477ddb249bb50439aded753f3e45f9b163f1ad919186fae1c902"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7356eb4e47342359552881e6ea359bb9276446cb975e3f8f2835098944583d91"
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
