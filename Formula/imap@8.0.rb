# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.29.tar.xz"
  sha256 "14db2fbf26c07d0eb2c9fab25dbde7e27726a3e88452cca671f0896bbb683ca9"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "59470e924a3545e81f40277dce886a1363f48c9daff9092684b743ba5a9d4ec9"
    sha256 cellar: :any,                 arm64_big_sur:  "f9fe2802cc5e4d04650dfa895065d36bee94246e5f563ebcc1836914976363c0"
    sha256 cellar: :any,                 ventura:        "fded9ef8fee30722b86879b2902f55234abd63e494ab06ce0e8ad605943efb0e"
    sha256 cellar: :any,                 monterey:       "9f1a5ef9a4136452f66ab76fc6c8679bf336e7cb99afe9aedb4bc193d7de6015"
    sha256 cellar: :any,                 big_sur:        "b14a5422514b15f1cdd6c779137450a2024bf05f751aee326b3bfe9f85d65b54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8bb4db906ef7ea8af73a97dd50548c72d350dee529697ef0dc152a70c79f303"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
