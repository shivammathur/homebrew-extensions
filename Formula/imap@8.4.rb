# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8fc3615a7a1757953e044682edfad3c99ba5ef02.tar.gz?commit=8fc3615a7a1757953e044682edfad3c99ba5ef02"
  version "8.4.0"
  sha256 "141936e71ab9a7d7509b61d307ca95142cb8246f97ca3583192880dfa6a80140"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "458272e760360df854600d41a7ef34b9101a237dff322d6921e0e12ead0ac3fb"
    sha256 cellar: :any,                 arm64_ventura:  "ff81096af690ea41b9e9b25dacfc7245bea8f2f45b586a5f7c294c1d140b5cdb"
    sha256 cellar: :any,                 arm64_monterey: "ffbf85c8897c604676c2d4362a28f61ec926fbba2be9fb501a7708f7812e2784"
    sha256 cellar: :any,                 ventura:        "3c3971a7f3b6209da3705a560791272000eb7ac81f757e42c217e999fd460a06"
    sha256 cellar: :any,                 monterey:       "57e81e9a18820d47ee30d5e3245308f61264add4247bcf30a030a719a35ed5ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "324cf25928b99e413145605f5226d1aab0d5f2cf2612f06d531458cad8e05d8f"
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
