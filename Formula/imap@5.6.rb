# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2e922830b542a067a306870dffd20040f34fb05c.tar.gz"
  version "5.6.40"
  sha256 "04c58a4a21c99f3a8df74c37141231691497ebf50a5dce3479f168de7b6f3a5e"
  revision 1
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "7403c048beb8a88341234fc6d0bd639847cd39d52f930e65348531606d76932c"
    sha256 cellar: :any, arm64_tahoe:       "f5ca032b0ee54624ffc18eddf56138bfb6c92c4c17c02a4b8b62747c724506e6"
    sha256 cellar: :any, arm64_sequoia:     "d1749fac9089e18b677a55c5ef80a2e2430c01ffe7d5ee119a46ba06b87dc3b9"
    sha256 cellar: :any, arm64_linux:       "4eee36fce81b8ae76ddcad525ac3d28fb9fe95cf871bd92b003d4603b28aaa8f"
    sha256 cellar: :any, x86_64_linux:      "af9481b1f116fb9de82250d6d48d70fce5b67499baa62c762a2355e1c3accc2e"
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
