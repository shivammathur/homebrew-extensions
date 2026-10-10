# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  revision 1
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ed918345df94ed054c3978b8f984e6644452c1ac4c315f36089b14068f9df630"
    sha256 cellar: :any, arm64_tahoe:       "76f8b346511ab731d53ac1e36b5097e603faa4bf32d2c7137c28ae7986c50879"
    sha256 cellar: :any, arm64_sequoia:     "e3bce098a10d73bd103937d534b4ba0eb41d7280d80c69b9bd80500be09695b1"
    sha256 cellar: :any, arm64_linux:       "4e67d871429e934b79501044193b87d76630b8278d10b4c2277c1538995ef4bb"
    sha256 cellar: :any, x86_64_linux:      "12925c649428f2820a5293ce4949981a52d5ec3ceee322f17ea7f82cc9ba6190"
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
