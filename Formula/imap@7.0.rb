# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/95ef8ca4f13d22de7f23b272c079365069aeae63.tar.gz"
  version "7.0.33"
  sha256 "412db3946a1c2813d46a68d5cd2a6d3a78dca93c0f06fcbe598778159f1e67c1"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "62433aff79a67c84d1999045c90a388d609f2adf74a197164101be0cb9622ffd"
    sha256 cellar: :any,                 arm64_monterey: "f96966d1283fc98d1c9b2595d33b192e9f57c06a415b0ffce6b4e8a870747dd7"
    sha256 cellar: :any,                 arm64_big_sur:  "d5aee58fa1f9ccbc8bd7abe20802ab31de75a258ba7eea1df79fc8944a7e7fd7"
    sha256 cellar: :any,                 ventura:        "c04d9bf6578736b9662714cbd42f691d5aca1dad7f57b39e7c089a1554e55e30"
    sha256 cellar: :any,                 monterey:       "a9554e06d4780306e3752377456e5eaeb671fc2847ee50eb26261cb2ac956df6"
    sha256 cellar: :any,                 big_sur:        "764c99f925fa8d6137a4fce24fb35a7d7b6cf152f1367c4405738548cb80f2b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb8bcfe76868576cb7a5a287668b03b14046a20e5eb18e4a36af97cffccdf2da"
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
