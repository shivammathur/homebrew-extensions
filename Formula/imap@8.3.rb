# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.35.tar.xz"
  sha256 "ff4630fbbbd94359134b7d3c223db59329905bdc4f5a9ef93d257b48e358619a"
  revision 1
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c1356d6769bfb59e262d26e271d72a8ce200439284875aa6438c9f1d12a23709"
    sha256 cellar: :any, arm64_tahoe:       "06320db7e87c29d7aba35f5c74507c79683e4948800ac991ab165ca1a35bc9aa"
    sha256 cellar: :any, arm64_sequoia:     "2e6fe088f84b529091ea83a9b0da08fdf1e3ddc78886b0babffd88de328355f5"
    sha256 cellar: :any, arm64_linux:       "c6df7f9f2faaf68d0b7721954b11edc7b54826e699cfb962d1dde6a3b287e9d3"
    sha256 cellar: :any, x86_64_linux:      "0327099ca788177bff6e174bc3ef016a2f0d4c47fe15a0f47bc37643b9234131"
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
