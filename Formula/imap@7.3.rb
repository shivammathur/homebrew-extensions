# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url ""
  version "7.3.33"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "51352c0d8309aa4b39fc4433440b0b377ca1a3102b8e2d78edb2238bbe04eab9"
    sha256 cellar: :any,                 arm64_big_sur:  "fd45098e23caea5b414d3ee428305f4058355379c12c38e5f0351ee7bb8a141e"
    sha256 cellar: :any,                 monterey:       "b870344d2bb38eff861f8be8477a05cb92543df7a76d67bc5e52f92830e88201"
    sha256 cellar: :any,                 big_sur:        "7b43f78375ebbfef8a432c6c33ecc43b3c93345a59e04096309208667355172b"
    sha256 cellar: :any,                 catalina:       "53be6b3830f022b7705d8af9f3edbf77dc1d3a295e0cb075fc10ff6cb2e3aa74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f9f99a39d3c1d55ad1eab3f38e0ca341fb00a28c4f15399e525d62385dbffa1"
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
