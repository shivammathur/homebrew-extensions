# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d453a327e0075c7a8c5ae8cad75bfcddef2b1289.tar.gz"
  version "7.2.34"
  sha256 "f173b9213c19f3d88bf674318da7e956c25b2591129380270aaeed674cb9b55b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "27b9272edf9be26f37232ee13a5fe988910f68ffb63d3667d6bee3b02f4843d2"
    sha256 cellar: :any,                 arm64_big_sur:  "e7f057ac5872391039e789c8a6111263a83181143345772f70ec760e93a79b43"
    sha256 cellar: :any,                 ventura:        "7fbd2ba713a07aebabc7c0417473fb9faeb36532a0dd13fbc16d26816cdcfe6d"
    sha256 cellar: :any,                 monterey:       "9d181d5dbbc03b2e06f6892d29d257a4576f93ba489abfb2af9a91105db86889"
    sha256 cellar: :any,                 big_sur:        "18bf4839427eae8c566976caac46df46b9c844cfac41990544111042efaeeba0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "797b85e3b652513ae278710d96fa8f786c3986e8937732d38ff1f794c393a480"
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
