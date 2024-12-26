# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.27.tar.xz"
  sha256 "3eec91294d8c09b3df80b39ec36d574ed9b05de4c8afcb25fa215d48f9ecbc6b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0aa647c9548148750d3bbd0e4258df25c3ab845f1e8a3d23e7a1b9f855d41cc3"
    sha256 cellar: :any,                 arm64_sonoma:  "94b2a515af3b0f4d6aefbacc73ada2cd9f99ac2a6c918ce46231affac2a47c64"
    sha256 cellar: :any,                 arm64_ventura: "5aad77f801e1be12e2325d562b47ba40e5291c994b2e32af1a0e4cec48592331"
    sha256 cellar: :any,                 ventura:       "fd1faae20544e64d284f37a2c99194575e8530a8768b37ee4959638ef9d60653"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7c142edb0a13c2f219a2b45391b86a39a84bb52958ce2752dbebc68fc3be555"
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
