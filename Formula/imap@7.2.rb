# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.2-Security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "eedde5c4d9a388cb1ddc8c04378e6027f358c985825aadd8526a2a7a5543eb83"
    sha256 cellar: :any, arm64_tahoe:       "0d9275194b17c2992281a73fd1878ebeaa17be661314d1e207c69fa5c9dec750"
    sha256 cellar: :any, arm64_sequoia:     "19aef8524cf44338d1c38130125dd673090bfed0e37fa3c0ef8ce10d9e12f8c3"
    sha256 cellar: :any, arm64_linux:       "74daa3f5dbbeccf0bb7180ebf735312e313933d9c4e74e878ac3f510eabb0290"
    sha256 cellar: :any, x86_64_linux:      "ebe97b9e8d50c57ddfdc34e6395a96393b3a7710f6692d9dba8270e4843a0681"
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
