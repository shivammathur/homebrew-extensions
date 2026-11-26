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
    rebuild 4
    manifest_sha256 "a973d042bdcd810ae074d603573dd0cc2bee954b34348bd8744322baabd1ec74"
    sha256 cellar: :any, arm64_golden_gate: "90384c54cd55f2d09a35daaa24f0eaa4088b1f84241ef46a19d0873ec01f2f4a"
    sha256 cellar: :any, arm64_tahoe:       "4b52cece694c3bcab16766ea8112d6fe859babe36fe524c3ae536b68332e5bc7"
    sha256 cellar: :any, arm64_sequoia:     "ef4b04521a65c05accb894354b356fce72a106eedc33f5d0b6ae0022a8666906"
    sha256 cellar: :any, arm64_linux:       "2ae5fdae2e01459e2d4c3317bf0bda08a269e1c5a0f8dba1050daa321b0dfb5b"
    sha256 cellar: :any, x86_64_linux:      "7e400a1b1f0263d681ec79b8f02c5cc233827e1290806449d3a312638adb90a3"
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
