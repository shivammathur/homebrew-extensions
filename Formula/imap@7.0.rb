# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/541ed65f675463aea6c6eab55de38719b2d10625.tar.gz"
  version "7.0.33"
  sha256 "44a0552346687dffdeabacd4f9e641eee84f2630e852ccfd44c49e0da2fa515e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "2caa94eea58317937eb0a174d0dc93dc73935679c3e166d32b0a57836333e7da"
    sha256 cellar: :any,                 arm64_big_sur:  "fc67e795515d2ef6619ae3c60ebe0ced6539b8bd0e353c564c6f88aa25e5f87b"
    sha256 cellar: :any,                 monterey:       "eb13737233afc92f39ddac30329a872527cff62db73bef8fd2f5ee88cccc1eb6"
    sha256 cellar: :any,                 big_sur:        "08e6f9111563ecaea3bfef91fc1c02bb0e4882ffcf1050f7bfb0cb77ae94e50d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62ec0400a77160f1f8be30e8d2541b58a754fe5df4085ed69a3290990f4365b5"
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
