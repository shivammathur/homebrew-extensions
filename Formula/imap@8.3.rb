# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.37.tar.xz"
  sha256 "0237af84478b7a7649d3964153f1b8653d622550b846f56d63062de683fb86bb"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "55b23f1558615199270d67e48a514a196117bc6780e83ecc874045408a3075e3"
    sha256 cellar: :any, arm64_tahoe:       "26676d5004edb3dfcd3076770592ce6df4daa4fdc3a0d1041601837cac7d333b"
    sha256 cellar: :any, arm64_sequoia:     "67a6a299c5d99c95ae1625fefd0961d5abf7cdca847a16bc8a392f6e693cde5a"
    sha256 cellar: :any, arm64_linux:       "00602a4122c1cae879231e2d6fdb018c7d9c8fda79f6267c16ca5ecd25417146"
    sha256 cellar: :any, x86_64_linux:      "65b129c5672a0080ee3ff4059292939280a26e2ff81220e3f2a40c9bd168139d"
  end

  depends_on "krb5"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@4")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
