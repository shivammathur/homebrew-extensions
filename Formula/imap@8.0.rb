# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.12.tar.xz"
  sha256 "a501017b3b0fd3023223ea25d98e87369b782f8a82310c4033d7ea6a989fea0a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "acd7e77133c1e2ccd00ba4e42e6bae1046495dd8cb8a3edf871847817f853777"
    sha256 cellar: :any, big_sur:       "420b4615442f0b651c958e4ec69f9e7d3fc10be71e7be1758093a40b066eb1dd"
    sha256 cellar: :any, catalina:      "72658d2d10e8ec59d1425e3958e93e9a061eefa5d3f024da191d4bc5cd95c264"
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
