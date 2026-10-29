# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b896540a30a5d170797a1171b04dd872b88c5b.tar.gz"
  version "5.6.40"
  sha256 "8fabdeb0a133ab8ea9cb5e590030d824e7ae9ca7703c19a958c9628938d185d6"
  revision 1
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "c9ac07510aebd2c8ff33922b875eae6560b2d14d3c719761d27dccee54023373"
    sha256 cellar: :any, arm64_tahoe:       "222982956c67111912b0a5d8b4e036e757fc47a0761e9bf7227cf53e40a83d0e"
    sha256 cellar: :any, arm64_sequoia:     "3a0cf52868c158b247bac44ae4331c494b3217542fba59b2bc159a17c7edfb82"
    sha256 cellar: :any, arm64_linux:       "5e869009f1819a1a03c27104f4bbb8705a41f504a615cf8bcc6100cb7e77a7da"
    sha256 cellar: :any, x86_64_linux:      "7e95a7a770c78255a84c078352a6dc198f40e4d4b11289541ac1d74d9782e027"
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
