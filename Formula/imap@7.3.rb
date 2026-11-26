# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2013f21a26a5d3d3adefc2a6f903ff28ad2334e6.tar.gz"
  version "7.3.33"
  sha256 "69bf22cebb9cb2c381ca68be7088fdff5751c37d667286f9f11ff984e8fe5889"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "5b742600c940360afcea576b27bffc9e81d909e54b48b7f9c0ef9c78a3c9a713"
    sha256 cellar: :any, arm64_tahoe:       "93e00ba7150cf8c68b68138aa5d91be67a40cd90ab7ead4b7217976b03ea4937"
    sha256 cellar: :any, arm64_sequoia:     "976d332c62b5f2afcbaf271e712e08f0a4603ea5791bb35f976019c7e8ccc9d7"
    sha256 cellar: :any, arm64_linux:       "db5c6cf27aafdd8f056d0bb0bc7fe96c1c38110b61d9a290686cc8fee9c40d90"
    sha256 cellar: :any, x86_64_linux:      "1d07a6833d0a56fb6dd6bb69ca6971d034fd61451f01ff1fcb0b17a0c9242021"
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
