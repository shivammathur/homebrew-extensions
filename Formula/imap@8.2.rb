# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.8.tar.xz"
  sha256 "cfe1055fbcd486de7d3312da6146949aae577365808790af6018205567609801"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7a545b1e556262156dc29e297d6064b2a1acf737bf2196b924419f9a721eac7a"
    sha256 cellar: :any,                 arm64_big_sur:  "15565cc0cb0bd8bfa0a9f8aa809e80725d88ea10a7e36efa6d8919f277bb3a6b"
    sha256 cellar: :any,                 ventura:        "1fac25d7d6dfeaae2a5c9613ae3bc237206b1237f94d4b350e0627ca53f91e9f"
    sha256 cellar: :any,                 monterey:       "71934ca023dd5a59e2794d39452ab91d497aca383e63b523f7f543ccbf3aac6e"
    sha256 cellar: :any,                 big_sur:        "ecb2da47bdf11c10a518d4c7e9198bc95c76c9fdfb21bc2353fc7105146ae0f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64d980c54dd6eb3785454ffd4651094277d6d7528e8f3a0ce6b33b165368d552"
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
