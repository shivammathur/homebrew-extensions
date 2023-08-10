# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.22.tar.xz"
  sha256 "9ea4f4cfe775cb5866c057323d6b320f3a6e0adb1be41a068ff7bfec6f83e71d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "959d1afa8c0922465d877991ed8b71a538b7d4ab4064f574c41d37b859f88ae2"
    sha256 cellar: :any,                 arm64_big_sur:  "20b076e83c17997f604944ee5b5c1dee043f6fc1a69bca6590d53e5c6148bb6c"
    sha256 cellar: :any,                 ventura:        "ff267f121296d917221eb4e61ac95b4f2299084a2ea1eb5707e6e325ce09240d"
    sha256 cellar: :any,                 monterey:       "2aa9784aa552beee642cc5d296fc8e46e0163e1583cb089e85c1ec23e322a2f1"
    sha256 cellar: :any,                 big_sur:        "4b797c869c6acd750eb0b154063c40e95d2c8a21105c1d64565ea441c4728241"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f41f99deef52b4a80757f40d5aa4a14ccb28d02fc507bceef2d467ad0e3f441"
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
