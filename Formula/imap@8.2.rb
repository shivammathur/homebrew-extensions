# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.2.tar.xz"
  sha256 "bdc4aa38e652bac86039601840bae01c0c3653972eaa6f9f93d5f71953a7ee33"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8934d7525d0723f5efbaf6b29d1a70d5207823ffbd2a10c959c961ee008fcd12"
    sha256 cellar: :any,                 arm64_big_sur:  "6247bbdfe6bb78d18f3089c89d77221129dbda9fcf7d1f14314b6e69adc0a311"
    sha256 cellar: :any,                 monterey:       "91fc6c15ceed4ef2cccbec037eab3d3b8b0d32a1bf0bd8937cb86c1ac0148668"
    sha256 cellar: :any,                 big_sur:        "d79aa0d62be5fd9b85cfd2decce532ab18515f234ba85ee8c53c215165083893"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "52159b88fdecfdbade11e18afbfa18d28d3e332bd38bd701b5da51f72ddc995a"
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
