# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2874e5fa052d54affd31ed5eaf3e0d53c9116c93.tar.gz?commit=2874e5fa052d54affd31ed5eaf3e0d53c9116c93"
  version "8.2.0"
  sha256 "955b8ab936105484edc1cd4ef10c3b25a62634708ff30db4afcaf5a9393e16c5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 42
    sha256 cellar: :any,                 arm64_big_sur: "444220f8ae00a7fb124c36db2a51056376f1ad7e38332e888bc903de4d574928"
    sha256 cellar: :any,                 big_sur:       "addab5f247e37c7d3279da5d209762ac4fc82477f62670c4135b49c58f1a3dfc"
    sha256 cellar: :any,                 catalina:      "71e6a3e5dff830cf05c85cbe76818b4929ca1836b73be255119ad13d35a0cde2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51f0931f8dcb2da95b55132a5e5e3bde5883309f15a219b5dc79dfefa10a3ca7"
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
