# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c032381da0bfb6457aa9cfa7a430790f6eab8178.tar.gz"
  version "7.2.34"
  sha256 "357f57334b1c775b4e9bd446717414dec9e15c3c30a4f3ae61db43ce1273c05f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_big_sur: "c5ca3dfd27a5109318a2273e3086bb834eaaaf0f0d9e914c0036cd247517924f"
    sha256 cellar: :any,                 big_sur:       "24ad03f75254a5c879b7b04cff51683ecb3b360da8f5b4a5a803c0ec3fbc1387"
    sha256 cellar: :any,                 catalina:      "4e2527514d4e9eb00d42a6d3060df47e37e955d0416c3979f84f6a677cc6e21a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8a0d41641f502f8e42389c89cd12d55c53e5155cf40b0200769a8f23668617b"
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
