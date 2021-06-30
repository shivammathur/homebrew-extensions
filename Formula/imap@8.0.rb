# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.8.tar.xz"
  sha256 "dc1668d324232dec1d05175ec752dade92d29bb3004275118bc3f7fc7cbfbb1c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "c263393b02a112ff51b382a87698aa8bc068fd54e549dcfcab943950444a1a40"
    sha256 big_sur:       "2630c6e97d413172ec2e635cb65583d52bfb222f800e2318297ed3c157a97d1f"
    sha256 catalina:      "80a02762a39e0f51152a232d2e9e8eeea30eb264ced64b3ee02cf28763913dd7"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
