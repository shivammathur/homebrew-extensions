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
    sha256 cellar: :any, arm64_golden_gate: "8f0ff6d1835c59a28b25855cf1bcd4a2ae5dcb300225734e07527e766bd607fb"
    sha256 cellar: :any, arm64_tahoe:       "e032c4d8610c01c644a0338d920c0849e64bca575c289be3da25c1d1eec8b849"
    sha256 cellar: :any, arm64_sequoia:     "3b42b9255738c409e420aaeebdb83ffd14910da14d51b4136671e7b802012a43"
    sha256 cellar: :any, arm64_linux:       "c51e5f5347090a7d7b0a3b32499af9e0817e91b5188f9344362d849ebaad90fb"
    sha256 cellar: :any, x86_64_linux:      "307be72ecf6d0aa216dc4bf16ee082aad597d4274494c3fa2a760d6bc08b834e"
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
