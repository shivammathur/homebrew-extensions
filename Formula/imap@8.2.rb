# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a814afb08823bb0cdf4ae45f67a7db83c8be9cd7.tar.gz?commit=a814afb08823bb0cdf4ae45f67a7db83c8be9cd7"
  version "8.2.0"
  sha256 "584d2925889a7d388084150865fa238634043f38f2e060c27ffa8ac4d682d5ec"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 80
    sha256 cellar: :any,                 arm64_monterey: "8e7d467f436c707a329f5ce3e8a2ba361254f920164a0230b602a3f741ddd95f"
    sha256 cellar: :any,                 arm64_big_sur:  "584ff08ff97218a1477a6ae4f30d30d3c401149f95509e0e2d5f288bfe419a4f"
    sha256 cellar: :any,                 monterey:       "407a917e921b18fc7cda1a2649a0275dc1a23aedb7c442a5802c47f4c96cfe8b"
    sha256 cellar: :any,                 big_sur:        "a327a893431ce0a36e5974e3a0cefb3989c6f5e0bba7878757471fc0619aabc9"
    sha256 cellar: :any,                 catalina:       "4f481d418bf80e965d6b723103b9947f88f203c948c9172cf20c4b4b3ed043f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7352cea2df29d4cd6e36c314a86d3492b10ba6a64abfcc58efa51d57ada6264c"
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
