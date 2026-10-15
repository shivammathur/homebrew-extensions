# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2f0da72721b16b74c602d3c80f527e07d1cdd49a.tar.gz"
  version "5.6.40"
  sha256 "595bb86a07ce587ae98a04cf1d3cb23f2280a90867a11cc312d67a4b1e87911a"
  revision 1
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "41ae9965a09e79a8151c4ef0782e65934e4d3309228e0a24052548c215d4fd41"
    sha256 cellar: :any, arm64_tahoe:       "951ca198dd64aeb7d0bbf0b3928f2bb8fe6d4623a835fcba94ffce4095caf2fe"
    sha256 cellar: :any, arm64_sequoia:     "d0aff03d6256a6fe3b7dd3a6b277d85d1457db386f02dc1c1dcc2c422d25ae1a"
    sha256 cellar: :any, arm64_linux:       "9dd4d0342cead56581eb26cddd4207a12bc557c862df083f68eeec75ce83b50a"
    sha256 cellar: :any, x86_64_linux:      "3323dad8bbd8a52119b2632993ad0ffa63e17f7c35691f6f0c4b67bbedaf2e4e"
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
