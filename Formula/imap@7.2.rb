# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b9324026a97a5255ffa24107c48c6e2a9c0a8b.tar.gz"
  version "7.2.34"
  sha256 "c68605c387149e04a20b193fcb93c8b65a859b7ab3f4b77b12339f83d6583319"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "1d3629dd6be9edddc602eaed343cda6ad05663009ba311fa3153329a4428e052"
    sha256 cellar: :any, arm64_golden_gate: "4167fdc527ae6aa753c7df6daa53f402a711333571037746866a40f9968be335"
    sha256 cellar: :any, arm64_tahoe:       "e4e92698055e0ab57d34c3da8bd7a68cf18f8a5217ada491991a8b3205b08e85"
    sha256 cellar: :any, arm64_sequoia:     "1f86a41cbc540e3629daf9b6e8e353f40c4e4d2aef06a6b7bd1913b816cba319"
    sha256 cellar: :any, arm64_linux:       "ab6f002fef1f5dd5e2ec02f179b94388fcd3bc495b6d0bf5f8029a729115f4e8"
    sha256 cellar: :any, x86_64_linux:      "f3fc3d7b2e0988d24a37603b46e29bbfadbfa8110c896e6eed8216191bbfd39d"
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
