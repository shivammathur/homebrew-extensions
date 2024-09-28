# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT85 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.2.tgz"
  sha256 "eb6d13fe10668dbb0ad6aa424139645434d0f8b4816c69dd1b251367adb3a16c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "76bc651fc4dcfb785d0917ed29e85ffe72e1e074049be9b57158bd68a9109a6b"
    sha256 cellar: :any,                 arm64_sonoma:  "42639b36866f6f4b45827130753a7c2e6e1f4524c04cbb425ff667b79264c6cc"
    sha256 cellar: :any,                 arm64_ventura: "5b71defd9cf49140d64c8e7cb145c695c6c24c938bf4e9a611685637d8b62fac"
    sha256 cellar: :any,                 ventura:       "be0d38fd4cb6cbbdad5501aff810d1d077b67eecc6f80c0392db93e6a3944ee1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f39a16f5f8eca9a154a5c1540d6c0b21a70fb98fbb09b11b014305f597e6fb9"
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
