# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e32d1d90177085bfe388128badb60fa45fee8a6b.tar.gz?commit=e32d1d90177085bfe388128badb60fa45fee8a6b"
  version "8.3.0"
  sha256 "61e937eedc679f611e2a72cfbd1870f2b51d11df4f69c0fb082761b2df28527c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "e6e06690ef29adb4a87893284378925c8eb68a44d6dd98162ab9c45754d5418b"
    sha256 cellar: :any,                 arm64_big_sur:  "7d4abec640953492d96fc7805c5dd58720f1ea0dda0ed334029d7f9306fb02ec"
    sha256 cellar: :any,                 monterey:       "88e833d42fbe8d59abdc2574829e3aeb460c921d7a9be48e442f26604e184f94"
    sha256 cellar: :any,                 big_sur:        "7791848deb64e282f1513daf0aff740eab71a29654b75f06d64cb87c2bf628ee"
    sha256 cellar: :any,                 catalina:       "370332a413d738d430e7bea168c0abb1fe50e7ca2506dc8a9a2093a002ae3b2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e74dbec92d07b96b29fbd9b355ffcf97bf275a2f3c93e75d66b7385b4e9eb3fe"
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
