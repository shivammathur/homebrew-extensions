# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/789867e844dc0465fe01a703a1bef2a7dba0c62b.tar.gz?commit=789867e844dc0465fe01a703a1bef2a7dba0c62b"
  version "8.4.0"
  sha256 "50d54b44e79ead9c0d63a0224328a06f2988c82e73f0fb46b6aba3bc30463dde"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "f43761918c6ac6e5b8cef104d5c2bc4a960170d7eb088d08e5767af6eba0a73b"
    sha256 cellar: :any,                 arm64_big_sur:  "525fd7e77ac2710b1f592951856ff328fb196173175f2b18279e99d06619ad77"
    sha256 cellar: :any,                 ventura:        "6edd7234cda338c7141488565a1f06f74094d9d087514854614e80ec4bbc15b1"
    sha256 cellar: :any,                 monterey:       "d77b18676a3e70f5619f379504d7acae1305a87849ad97ba3b39f9c9fdb9813c"
    sha256 cellar: :any,                 big_sur:        "081c2d1d32ae3cf0dcf69d771ea8c27803457045d94d5c038c3664bc08306f2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2fbb00ce1ec3facff983a0e10af62b1c70180ee79db0205f20e82142cc2ab94"
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
