# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/190a0202b4601d3066088ba913c2f1bda921ad8c.tar.gz"
  sha256 "3b70dac41c775c41913ff3a13c77beeaee375b995f41940e62ace648119c4622"
  revision 1
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "a2ec031003b8158fc740d298e45926cc5b2912dffdb48320cf23eec6169c8a2f"
    sha256 cellar: :any, arm64_tahoe:       "401e869c10b64327cbd4dd94ac318b41c0266b7f3823ea4238a7781076719b84"
    sha256 cellar: :any, arm64_sequoia:     "f13653e5c87d472b25fc7d70fde4c23e6b016fe45253d2741a913f6f1842ed54"
    sha256 cellar: :any, arm64_linux:       "3b5cd8a8e60e80cf8b79116c4fecc567fad869a6239de4f0a15635e45e36b3c3"
    sha256 cellar: :any, x86_64_linux:      "c314a7f8207f87991e1f898dc1e0db428cfdb04dd25cde9abe57eeae5b8be7d0"
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
