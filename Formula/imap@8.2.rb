# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e3ef7bbbb87bcbf6154a0a4854127b9cea8f92ff.tar.gz?commit=e3ef7bbbb87bcbf6154a0a4854127b9cea8f92ff"
  version "8.2.0"
  sha256 "d2f56209157ec29bf92a9ad4ae92a427eb6a4a223680b00a3cd0a473fa3939ad"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 38
    sha256 cellar: :any,                 arm64_big_sur: "e723160cc9f8cb9fced2cfb68b100ec9d8e9f89e77b75d88c457a6ea205e0cab"
    sha256 cellar: :any,                 big_sur:       "104c807771818cbb17c9d430ab470261474f984d3e9b2d29fe5034fa22292cd7"
    sha256 cellar: :any,                 catalina:      "149c81173482d66e35102cac55b0887372099d110104bbba8e5772083e603329"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ceb4f989fa7e32eefeced99a7f8f0e1f13236d883e410635f5797f5ed32f0452"
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
