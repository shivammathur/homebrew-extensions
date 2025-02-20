# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.17.tar.xz"
  sha256 "6158ee678e698395da13d72c7679a406d2b7554323432f14d37b60ed87d8ccfb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e88fec47b742ba647742ee88d83467cb49a4260ba1d09ceca0b02867102aad06"
    sha256 cellar: :any,                 arm64_sonoma:  "dcba0bfb8ba87d562d635e99f1e20bcef008bcd719bf01c727128104410351a8"
    sha256 cellar: :any,                 arm64_ventura: "c4fc3002873c1dc1ca47e5ca505c8e32b3ea34b0505a2f5a73460e144cf38742"
    sha256 cellar: :any,                 ventura:       "4152f67d911882ddb19106a78f1dc13c889ee350e2301fbd379a6695834ffef7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14e9d8fd9e8313468938149aa760279230f44f53609c0b8e20dbe89020bfdc94"
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
