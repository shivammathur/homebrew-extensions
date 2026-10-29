# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/34456d7558a6a1741fab48074c0c42d89b4834ac.tar.gz"
  version "7.3.33"
  sha256 "14d7086d3098273da345e1917ca44b6aee8f2f12db230ed09e03e5bfeaf5fab4"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "7b244a095924f92ac87427df7250407c04a8671c6549966deb3e0ca1c6eefa86"
    sha256 cellar: :any, arm64_tahoe:       "253ee07ed5381ef4f3643798c69ffd6812c5573331ff654b86cdd84fdd5a7ba1"
    sha256 cellar: :any, arm64_sequoia:     "baaa1ad3befd1f6288f187bc0c78745300fbcec737707d78f1ce26ca63cfe987"
    sha256 cellar: :any, arm64_linux:       "cd5dc6ccb7dd0bf2559b54be03b4c25e3c90f2a3cb6165187bb9ac1bd727929e"
    sha256 cellar: :any, x86_64_linux:      "99ff6dfb16d387918d205d70b215c2fd0f12b1a13a2a33ab79035839800283d4"
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
