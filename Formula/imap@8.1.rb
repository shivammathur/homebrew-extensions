# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  head "https://github.com/php/php-src.git", branch: "PHP-8.1"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9a4d2dfa5f1395c7a2528bd8708e2565721c5800be65104833a08dce31c239f0"
    sha256 cellar: :any,                 arm64_sonoma:  "c4ecca6d4bdbc3ddf5a0a5c6f929ffe07fdf02cd6e7ecb282a6a1eb7c7258183"
    sha256 cellar: :any,                 sonoma:        "2607742bf1ac20dfe28b130fb25f95288bcad13c70d281ffaad6bffd2222c6c9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "131279aa83859c9da0aa96f27ea9b0ee67bf127e69d76b282d19d11481b47f9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f97f6f16207d1fe1cc04af31bd55be30dd239692df90d2f8bd011cf7834e03d3"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
