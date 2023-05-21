# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.19.tar.xz"
  sha256 "f42f0e93467415b2d30aa5b7ac825f0079a74207e0033010383cdc1e13657379"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "cd6e319252c65b08aa38cbb0aabfc7529f8116c53594d81462c0d18c1151e15e"
    sha256 cellar: :any,                 arm64_big_sur:  "c9e0d7f160fc3f2d26d9b95d7c8e6e3b7e9555126b92bc163f4fc3e6a68d9b05"
    sha256 cellar: :any,                 ventura:        "f52f5bf1620553e14e9c130164bf36391bb50c289d8b9068355fe8cf56dff311"
    sha256 cellar: :any,                 monterey:       "ca4d6b261e289f30d5b0c33a86d9b007f6fdd035450acb58de1553b105dfb6df"
    sha256 cellar: :any,                 big_sur:        "e70d3f6c7fe6558529308111b0e37b2917f58e58bc3f70acc72d9ee819233452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4f00431b75c7c35c7dee4173ee12c8e75698aaf1fe0c7f5d1cfe27a67888272"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
