# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.3.tar.xz"
  sha256 "b0a996276fe21fe9ca8f993314c8bc02750f464c7b0343f056fb0894a8dfa9d1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "dbe1e21a8775900fda74a3e04e4e365335ddd4deba2bc26626e92026525d4a41"
    sha256 cellar: :any,                 arm64_ventura:  "d22cedb6c92f76a6bae3bb0559b922f845f1da845e1078d293a7e71f0d5e1492"
    sha256 cellar: :any,                 arm64_monterey: "48c59dddfaa5114596f0342f5de74cb56798669a6303f3c3706fca59326694fb"
    sha256 cellar: :any,                 ventura:        "9ea63368867a36550262493ae4cb96a8ad69220e648eb2e998fccb6f75f45991"
    sha256 cellar: :any,                 monterey:       "f459290408cf588844d4b3193381e885aa3c8a08d70dac2b74639c254cf31427"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0e6ff138f77789bf6e67329e551e8ee360b459f115f6ffd1d28945c9d662b197"
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
