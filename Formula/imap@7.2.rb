# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5c72b2e079fff3aadf142a084de94af8133d1c4e.tar.gz"
  version "7.2.34"
  sha256 "a04d562d4ef7ca0ce70209b66519394a26ee3f7187ff652b375d111d34a1fb9f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "d02ab5ae13400c88b8cbd7521acacceac501ff68b2c650ce31f984dbd65d7692"
    sha256 cellar: :any,                 arm64_ventura:  "33ea57c3910ebc4e103e94ee2413832821ab07120b631b94164b28abf8c1117a"
    sha256 cellar: :any,                 arm64_monterey: "033cf048a1d3d3eeed3a618a8677127dcd6543f1a8e2c2813d090fdc23ca6719"
    sha256 cellar: :any,                 ventura:        "6dd16d61f72f87b5dc5493a6405037bc05f9b313515fd6946c60abacb16eed49"
    sha256 cellar: :any,                 monterey:       "594cde87c8530c8e8aef94a1a8fd3e504d7d8ac7365f3885e8f16694a560cf9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "94b86beb7e18957b5c14a5dcad8bfcdc2ab65ecc3ef551ee519fe989d3f2f00d"
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
