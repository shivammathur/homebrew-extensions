# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ac2d85da4dcd9616d08f33291a0cf7f6e4d1bc8d.tar.gz?commit=ac2d85da4dcd9616d08f33291a0cf7f6e4d1bc8d"
  version "8.2.0"
  sha256 "f4bb3bc315a4cc9e23cae89e09d083d0204cfcf216cc88192cef1583ed7bd316"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "153583c3dea29c96f50ec326e5fabbce6f58b8acf88cd1f5d53c8c9fb73a174c"
    sha256 cellar: :any, big_sur:       "baf14df1226262fbc6a33f9e9bd3931390851a71b0bdd5f61e3d3c041a197f0a"
    sha256 cellar: :any, catalina:      "781a0f94be2b8c6cef757762067aa891c97690a2c977c1bb92c4ee5b11319351"
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
