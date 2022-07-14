# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.21.tar.xz"
  sha256 "e87a598f157e0cf0606e64382bb91c8b30c47d4a0fc96b2c17ad547a27869b3b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ef0df38def6c044afb742b3594c5b65c2ab801849a50243b4c277e8dac72be20"
    sha256 cellar: :any,                 arm64_big_sur:  "35a07aa9931451d9bbb4c96ece03e093d7ec1c31800188dfa9611ecc94899b76"
    sha256 cellar: :any,                 monterey:       "f3f1dc5affd0d65f1b9e357ca180a7784b15c53928108ef45f1c2b9537d0c97b"
    sha256 cellar: :any,                 big_sur:        "cffe0e50e5d8f8b10d36420aebd8132ffc1b995b47fc9a521631608a0218e6ff"
    sha256 cellar: :any,                 catalina:       "7827a3ed22b76b8e903134157b0d0a15b446fa2d2326e57da2c90f6db896577b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf42bec5b54392e1d205ae48290a26da1f9cb209c345ff4af45b7fa6081876a3"
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
