# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.13.tar.xz"
  sha256 "b15ef0ccdd6760825604b3c4e3e73558dcf87c75ef1d68ef4289d8fd261ac856"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fbf7f8b8da0c63a8412eaddbbfcabb59b8397e0a318a8466980545f76151291e"
    sha256 cellar: :any,                 arm64_big_sur:  "45e0adab4a73d8ceb7e5efbef3579be8c244ee440fa65281161033e3e0ace0f5"
    sha256 cellar: :any,                 monterey:       "bc16d7559dcac9c7f7055ac09b688b06bda1666322a652cbd275e4aae3dae533"
    sha256 cellar: :any,                 big_sur:        "aa1e646f3d315b9b1e8e1a74b9365d4d1c6f4991e60aed079c68188feeaf5225"
    sha256 cellar: :any,                 catalina:       "24ec43005d719e49bd779667a9f0248db4be7b2788f3df39bed8e021a6a5b4b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8802ad4a7a33e9deef22a4b0e52eac6288d44c5afcf37edd5b25bad6032c8974"
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
