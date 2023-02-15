# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.28.tar.xz"
  sha256 "5e07278a1f315a67d36a676c01343ca2d4da5ec5bdb15d018e4248b3012bc0cd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c0333d1b41f01eae54d8b593c34b2b4a50059ab2713d79626dc1268bd0dffb39"
    sha256 cellar: :any,                 arm64_big_sur:  "e2baca3d685fef4d67964c59ee1f46969b9cc619e4fd6efeddcbbee064459978"
    sha256 cellar: :any,                 monterey:       "97a8c8508398627baeb1c263cdfdbcaf5b84ba4d88ff5146023899e95f12157c"
    sha256 cellar: :any,                 big_sur:        "f922374f1a6e96761f8a7eac8698ad39f970bf68294d2ff008de33d51efdef93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a2006b774d7bc38dde9b1ce5cc295ef68e1016e85e63f13785c9ef61395bf11"
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
