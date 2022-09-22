# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0b2fe40d23d88106af3b15d5451a7dcafb961132.tar.gz?commit=0b2fe40d23d88106af3b15d5451a7dcafb961132"
  version "8.2.0"
  sha256 "66726bae8da5e527a5fc50560c127732657ca7be30e56ee233a1e29bde3fec17"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "31427b379033ef13f3e37fe96ae17153e20fe418015be78d510a1251d96d0bb9"
    sha256 cellar: :any,                 arm64_big_sur:  "abd5b9c65b76c44e30cb5d51db910158893d140c4ab11e45c2619cbc8a54e7d5"
    sha256 cellar: :any,                 monterey:       "dee1ca2aa70a90ba53e3caee53ea4c921dbe5307a67c3bc3b7312b16bd56afdb"
    sha256 cellar: :any,                 big_sur:        "b5c7bd8d396b88c7ab1e38f932249cec557b7971edb995e21347de60df49a917"
    sha256 cellar: :any,                 catalina:       "a8eb64a9e6dd2429621515f1849a91a6ca1dedc5ee5a34ab4277ec58c7d57bed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "354d37f757d2ef55122a3661cd1e2a86d5250ff1bc12375a2adbc172226cb921"
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
