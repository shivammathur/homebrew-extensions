# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f07f37f1acd43b411bb7fdcc3fbd0d6c966183ae.tar.gz"
  version "7.2.34"
  sha256 "56c3325726abdb5fd1a4d23fd3bdb2dca33ed3293721e176acce8fcfcc1980bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "9b22576295408beb8f9f5ff0da30e3b4d649592dc104585c15a8ae01095fe2f3"
    sha256 cellar: :any,                 arm64_big_sur:  "c3f920c5599525a9661f84b6d1869dd1c414cd0e54e42afbc19d4fe71e40d842"
    sha256 cellar: :any,                 monterey:       "37b177048a43cbfcea0518825ecf1e59d2a815ef4314277277a2c569df2a64b9"
    sha256 cellar: :any,                 big_sur:        "8002b3a4936c2ff1548495ff7fbe34473b6780f1f263ffd9994fd00d20646b88"
    sha256 cellar: :any,                 catalina:       "f4013446a0256c9d58693fe251b80461a4e4a94abd7e7913492d5abad9b2f613"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bb59b1ce7d2afbbb0f83b2ce8c7f283357b6d74321173ddcba8190e7bcf05a5"
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
