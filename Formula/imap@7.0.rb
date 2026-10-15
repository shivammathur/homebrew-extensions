# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e3a3b5ee45052f181393e7d9361895f169ab37a1.tar.gz"
  version "7.0.33"
  sha256 "2ce06a971c0029af7bec9247f2050e7f722eb28c094c639ea2d18acd780432ae"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "81b4ed23c5642a852719a927eddf821f206653fe7744889ae140589ce35fb18b"
    sha256 cellar: :any, arm64_tahoe:       "3332653ad76cb24c4c0fa15270bf628017f981f3709ee4b848d67304796fb1ae"
    sha256 cellar: :any, arm64_sequoia:     "3993ad2b6c8ff5504095e552d74d51a5299484859bc13a2e10e82d9f45d1cbd2"
    sha256 cellar: :any, arm64_linux:       "38db556ab1669a0ad4444805c20353aaa40ae58d694dae45d1ddcdc220720844"
    sha256 cellar: :any, x86_64_linux:      "0518e2b0fbd63cd4c16de1d58775e11dd469d9b559df6003750fd70b087681bb"
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
