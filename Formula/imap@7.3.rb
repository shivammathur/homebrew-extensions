# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e74a5463635fef78a14c70e28321b7208f6d921c.tar.gz"
  version "7.3.33"
  sha256 "a0929a429fef1adfb8b46c51322f0152e6735e98b1f2de2232fbb591559420c1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "db1da31c4ea60d7801021927bfd63743c4cc8e348e174eb2bcd79628f24a8f45"
    sha256 cellar: :any,                 big_sur:       "8541dfac57887a2fbb3ec628f3d511f8acfacea4de20cdd4689abc7b7ab44e8b"
    sha256 cellar: :any,                 catalina:      "09cb37c6adeae8d2c5fe27bd4f9ca9bb8519f3e79f51e63e24c523ee8290e3ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c009c4a6953594f0872f3c9ba718f3fbeb9f388729329ff20b6041e9ceae589a"
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
