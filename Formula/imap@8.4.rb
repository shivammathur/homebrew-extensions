# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.2.tgz"
  sha256 "eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "cd200a65128372dba1df36b98a5c72f0324a0722d8c0e10bf82ec679cc2333b0"
    sha256 cellar: :any,                 arm64_sonoma:  "5bf72fc713e56bf2e6ed78b663f6f530e63c48dc849b2c2b5f4a66a27a0a48ce"
    sha256 cellar: :any,                 arm64_ventura: "ff45db630952aea0c325887c432923f50aedf2c2a51ce6e2ecc60aae50974a6a"
    sha256 cellar: :any,                 ventura:       "f6980dbe30382f956d9c928714db387a63ce91c3cc47c3dab0f0ff6f9335be08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8b860487f47fd9030fc0ae09ad6c650e9110f0d6435856d250cc560438ba2a9"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
