# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9f3f6763497aa556d3fc56df7e66f44b8de49815.tar.gz"
  version "7.4.33"
  sha256 "cd3e5db449ebad253f678afd3421ffd108d6a3a6bd7ad1d05dc80988b96b015d"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "dac5d65c9913a2b9b2db3b348446f6728478dfb56cc6583376414ecc0c29ea5a"
    sha256 cellar: :any, arm64_tahoe:       "1b53ea203d05f4d2a4e2331bcee7d7bd802cc0a0a34ac382289b5e47827cad7f"
    sha256 cellar: :any, arm64_sequoia:     "e63a89a37dc97190d36d7ed1c88e656fddf1f5b5399f4a804f979bc87aa2a0b0"
    sha256 cellar: :any, arm64_linux:       "fbed62275bde5ed05a4e58a5a239c02bc59a8823b2294fe9e41ba01db3a80188"
    sha256 cellar: :any, x86_64_linux:      "5ce41c018369f0f4d23fcc8d14bd56dc9a03fa5ae80c16cd6b402ec668bb5285"
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
