# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1c9dd35b4ab8c7b42297c7950f9041c3ffd4d172.tar.gz"
  sha256 "c5c64d46f1d150d91bbcf8d36dfc5002c192f1984c42332a81fe10d0fcc52b90"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "b7162a1528da53eca5869c270b89e71b85ccec2bd0489b4fb42586b4d43ab990"
    sha256 cellar: :any,                 arm64_monterey: "1151c783d7b55d696104a196b19778bb5681879e11c1577d2b51060fa135aa6f"
    sha256 cellar: :any,                 arm64_big_sur:  "82bedb3137f5cb566164e1780278e2e4e192d7436845125937c557f8340f4638"
    sha256 cellar: :any,                 ventura:        "8d71cd482ee0f4a7a87ec0653439b91c79648d8792466cb0f2fd80dd46211f02"
    sha256 cellar: :any,                 monterey:       "28b7b66f380b5ff5b8f146a9ee6d335cdd2e7a2514a28c619074f70e75ec1d4a"
    sha256 cellar: :any,                 big_sur:        "604a752234a865b5cdfb3a079ebac62f2b8ac139c4aa9c737c243d2ddd97b83a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1358e690ac013670103d62ee20f09d2236b58b4eeecb90c931ee1abe2f91264d"
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
