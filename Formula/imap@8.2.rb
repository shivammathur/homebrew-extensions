# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.5.tar.xz"
  sha256 "800738c359b7f1e67e40c22713d2d90276bc85ba1c21b43d99edd43c254c5f76"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7daf72ba54927db69ed4ef2e3e0022ef5d94f0f876fe49940a707c87e885bcbe"
    sha256 cellar: :any,                 arm64_big_sur:  "8ca8bb621201d0ade8d8af025cfe2509e236dd9852d01bb0584aa1f792e45f8c"
    sha256 cellar: :any,                 ventura:        "5d8fd6e7cb556adf97c2db62f362ba237becb0b64fbe7584d5241256ee28d6dc"
    sha256 cellar: :any,                 monterey:       "cfa0a700163f952c0333a8b4a0afde6e233781350cc3125440df803011d0887a"
    sha256 cellar: :any,                 big_sur:        "ad807e48b11d3b47bd01cd1bcbb468e53fff734b612cb024f0f1edbd820f9021"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fc5b293710429477e72a374afd42decc981237dd5abfcfa0b78c1725dd2c833"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
