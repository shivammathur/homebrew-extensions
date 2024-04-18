# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.6.tar.xz"
  sha256 "53c8386b2123af97626d3438b3e4058e0c5914cb74b048a6676c57ac647f5eae"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a36acea293d23b7ca9569140c0eb22bd673911a0fbb037f81f35320872bcb407"
    sha256 cellar: :any,                 arm64_ventura:  "3ed295778b69de778250b4ee7842508e9904fd158914345c60c03c1bbe120d81"
    sha256 cellar: :any,                 arm64_monterey: "58b8267316b9c12f5169ac3077189e83aa5d1f2b90048dc8edf03812a2939145"
    sha256 cellar: :any,                 ventura:        "142b55ce15be17b2a8cdcad761c5d518669097082cc9a7d75402346c14e05316"
    sha256 cellar: :any,                 monterey:       "0a74486c5cb4f7a1010f61a4a5040bf7466c46539ed6068734e1cc86dfe56c1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af5ce301100e5df0cb3136a612dcf287b48095f68f354cc0b482b401e828cbfe"
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
