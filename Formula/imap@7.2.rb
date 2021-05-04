# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz"
  sha256 "72c9ae7a6b0b55b2837679d8b649e9bb141d5c16eff80d0dd06eae09a999e9bf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "b4420e5764679b18fe46e7a99c6db667fede559218130b898e8cbfc07d1e8467"
    sha256 big_sur:       "45228067734f63a8d27dd99f96d3f0fd5f190be00bf2bd11b4bedd48d26cda24"
    sha256 catalina:      "38391d5298159e2844c39f7541a94396fc1e89bbfcaadf573eff32344511d6b3"
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
