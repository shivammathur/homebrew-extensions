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
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "7f9e541bf09957087e0423e12648e6bc058f92773d01df7ab42d375229c69e99"
    sha256 cellar: :any, arm64_tahoe:       "5880931c43dfef22cb1832f3594865dfaa32560ed1977e61eea9caa7bda7a42b"
    sha256 cellar: :any, arm64_sequoia:     "c645494decebb012fb92dbacae4e0d33681a6eb402750b091e3a2001a2c5e461"
    sha256 cellar: :any, arm64_linux:       "ba85c0e836d1b4990cee62b72844e2f35ed4ed7a00f682c387a923184c76aa4f"
    sha256 cellar: :any, x86_64_linux:      "c62329656228516e0becb55351f3f9ec734a9416e7bdd640ecc9d88bd4ab64fe"
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
