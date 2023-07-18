# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6dd0dcf6e1eeb3f6fcba9b3269ca0803d7bbaa2d.tar.gz"
  version "7.2.34"
  sha256 "7aadc0a75d70efb425f8d74ea9e1a4a6826d5adfaa9807ed8d034d7cef1a7aff"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "4990a41346227ee3030455442125323908612458aebff70e36e2374a09802819"
    sha256 cellar: :any,                 arm64_big_sur:  "75ca2226092c044bd146b3fd016e7cfac0136ee6b830cca012a29667ff4a0259"
    sha256 cellar: :any,                 ventura:        "48c61ab4aa6b7201702bf4da608c0dfb627b769857dd293a40b2a9f127458765"
    sha256 cellar: :any,                 monterey:       "97b9e5f453a5877d9e89bcba577b124788f72dd62eac5a78513c32987d9f01a2"
    sha256 cellar: :any,                 big_sur:        "df736c626af0066d7111851536937e547037bfaee8a09056a26d6a10600aec99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "211e9a364be87db7286df9e7475efc0f8f46723dbe7b4286bc7e0d29d80f93a4"
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
