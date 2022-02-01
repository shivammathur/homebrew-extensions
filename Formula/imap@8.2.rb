# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2f5295692fde289f99aa9701528dcde4c78b780f.tar.gz?commit=2f5295692fde289f99aa9701528dcde4c78b780f"
  version "8.2.0"
  sha256 "be5c530f295656c6830d4b97164b012a472f4b792147209f4a9bc24091ad2ede"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 31
    sha256 cellar: :any,                 arm64_big_sur: "b247016ebf4066023302416390d50c17b4042ed5cb60887a2b792637eb0b7080"
    sha256 cellar: :any,                 big_sur:       "951d28559c80e6a75669134d22df02a67c3945f346d7b51ea05483f912d513d6"
    sha256 cellar: :any,                 catalina:      "ec9c45c726c99b9000026e7b796f85064624e5a0df6a25085362529f7fa8ec85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79e1e34e310cf32efb06dd8c6ffa091b3302c538bfa30b495d7ca6c8d4a5cc3d"
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
