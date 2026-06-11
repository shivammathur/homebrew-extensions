# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c8bf06235fe7fd4fa747bce70f7824a03823a6fc.tar.gz"
  version "7.1.33"
  sha256 "edea2c9b62a4cfeecb8fe0e377a2c64553463b195db251385b000f32645e343b"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "87ab6daa870ff301b95c37e5d53340eba2df1badc00e02ed8693307f7026c90f"
    sha256 cellar: :any,                 arm64_sonoma:  "bc4036736ab955dfbba07f5ae80fd7bbc37d9857de9c310119598e8176e373b1"
    sha256 cellar: :any,                 sonoma:        "f53c2c425c77b41d005ad22bbcdd4bcc27a41a9ded330925dcb0452314c74cb0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "af55ef66670a1557a98e3d8875d010259236c2ee586bc3cad09b549f77ddcc8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dc24da326746103613e99de047b745ebac437554a70364797ed6a38e9acee0f6"
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
