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
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "34ead0719b2e54acd1daa59e6d8925e484fd0f64003501003988f8ee4a3eb9e8"
    sha256 cellar: :any, arm64_tahoe:       "61ea1a94530777b446d97e5d95300a4879779b7df7cbc140bb7432f2d5fc6665"
    sha256 cellar: :any, arm64_sequoia:     "179f79c1a620584c38a76ebe0ca68d06e9db2ff23513b29098716e7d4196f91a"
    sha256 cellar: :any, arm64_linux:       "649649e4d5b959d94ce7ba1254aaa3a0b9912d20689ce54ee5e647dc70b804fc"
    sha256 cellar: :any, x86_64_linux:      "66f61af960f31c35162a05acc44348cbf027076f3a6e28db481003cd7f62b0ea"
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
