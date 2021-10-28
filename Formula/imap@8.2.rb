# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5e7e654514636f3cf9a07938825f83fb13317535.tar.gz?commit=5e7e654514636f3cf9a07938825f83fb13317535"
  version "8.2.0"
  sha256 "f5b884221849c0c14a92f10108d5b95c07aa75d334ddfb263a211f607889afb5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_big_sur: "5c23a23550aa897380fe51e9e0639dd0af54b830bff81e7c8aeb30b89dc1c715"
    sha256 cellar: :any,                 big_sur:       "a18767f3b4d850f5c3779346b03fb6ac33db5d1b12cf2991b91edac59724de62"
    sha256 cellar: :any,                 catalina:      "e9d069a51ff7e789b7e6b62d38fdfa94386e689eb64dc6efb03a47c558f92825"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e155ea07020106fa68dd947adbf376a512f43ad6cb2710f8f9160f513376dfa"
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
