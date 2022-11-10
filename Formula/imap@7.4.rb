# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.33.tar.xz"
  sha256 "924846abf93bc613815c55dd3f5809377813ac62a9ec4eb3778675b82a27b927"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7b5c8e65a05c42d4e942016fa905396f4ae3b57be9a0118108e79543d92a11ce"
    sha256 cellar: :any,                 arm64_big_sur:  "af0b8507060292d282f99c4262888f4a57e5efc7f78285eeb1fcdc79776ccd10"
    sha256 cellar: :any,                 monterey:       "9f9bdfb5bb74ca41db471f180a8cd719b1c7876dba3dc19ac52c5c4756b80530"
    sha256 cellar: :any,                 big_sur:        "dd385636ed98bc6b52ddc60211c4685ed18a5a0fb2b558bae8083188b3187cb8"
    sha256 cellar: :any,                 catalina:       "50c72c2c5b438552d203ee3c129e80ffe069ca3ec4f3d2470031eae6f6e31289"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "529be72cbd1a6ca19c954cac542b54e4d30786cc9523f2d4cdf10351e9f0ba70"
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
