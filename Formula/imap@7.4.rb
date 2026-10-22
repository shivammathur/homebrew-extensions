# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/066522cf9c489c59d41bfca7cbfb08eb36fe4cd4.tar.gz"
  version "7.4.33"
  sha256 "da5bc8dd8f95b172b9be7a355f5e0b783a409c01100d305ff234af207bd39552"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "ad394b50bc9f8bef7f51ce439fcfc59d8bcdd3a7614f0d9864f10460653992a5"
    sha256 cellar: :any, arm64_tahoe:       "a8089bbd81b6581111d28344541e359a235598dce949374284365334e7297315"
    sha256 cellar: :any, arm64_sequoia:     "78d049c47f9f215bb58f6acdfaae1ec4a201385e19735fea4314e7d744965790"
    sha256 cellar: :any, arm64_linux:       "7023e415f53119c3ab9fd2c672cd4da67a4def0e3923f11cced4b1132bd30f8b"
    sha256 cellar: :any, x86_64_linux:      "73463b302aad07f4d172e255c73d203f0a329db4fac564d8bc1fd795bcd808e3"
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
