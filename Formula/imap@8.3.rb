# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e32d1d90177085bfe388128badb60fa45fee8a6b.tar.gz?commit=e32d1d90177085bfe388128badb60fa45fee8a6b"
  version "8.3.0"
  sha256 "61e937eedc679f611e2a72cfbd1870f2b51d11df4f69c0fb082761b2df28527c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "e253cdc25915933a1a990e1a084df032e9a974df0a8ddb4dc6b64e75dfd1af37"
    sha256 cellar: :any,                 arm64_big_sur:  "afc9e2f969f289b281abe7830cd014a9dde75345aa90eee0951e84d1b1396822"
    sha256 cellar: :any,                 monterey:       "7de44f4d397cc83868128354542781af029c7b2a566574c5c2808e121f9f64fd"
    sha256 cellar: :any,                 big_sur:        "0b9c6d157bf3e376381664c808fa3c2b71d8435259c85223111e182ed652f26b"
    sha256 cellar: :any,                 catalina:       "3fb54dc8c196ef14aff65300d49d3155ad8c82b3e652fa6be91438e6b54ea414"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fff33e37a66ecc7fd0bbda9cf5db66480b7af89c96639569ec9d9cadf281e64"
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
