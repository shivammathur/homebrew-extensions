# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.6.tar.xz"
  sha256 "e9871d3b6c391fe9e89f86f6334852dcc10eeaaa8d5565beb8436e7f0cf30e20"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "e94111475c9dae857f90905123eda2f0872d2c8dc82ff11f2fadf824762bed4c"
    sha256 big_sur:       "6033f2bb8f8673411395ae5db20e2298837138451c86c5c76aa96f757fb369c1"
    sha256 catalina:      "d38efb3a1c09a671bee81c3d50d2875a5fc6f22d13ea51087c9ae37cc62ce131"
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
