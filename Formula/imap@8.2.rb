# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/30a3280df73c0751cab8b342824b8d9a6ba91e3c.tar.gz?commit=30a3280df73c0751cab8b342824b8d9a6ba91e3c"
  version "8.2.0"
  sha256 "16ea933f847809097c8445131f8545e0b71ba987ba3db8c8fc27694c7261f17b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_big_sur: "1fc81507dc055c5b9aa02319de98667f160b503afdcb4fc956da1654ca76f6d9"
    sha256 cellar: :any,                 big_sur:       "8375a88f4518fe61c28d80453b37af616db1e40d10d4480016e660ad236de436"
    sha256 cellar: :any,                 catalina:      "e45f20990a2d753e498adbe7b1ec92bfdb4d7cf12fe410853e6263ac72a304ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8fe0162bac5f0a407e726e52b059e743ae791ccf0211654ce2011432fb0208ae"
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
