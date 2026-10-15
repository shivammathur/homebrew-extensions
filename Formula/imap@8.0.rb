# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1c4ef2f91899bcb60abc223859fe5cda502fca19.tar.gz"
  sha256 "dcaa45c7634e2f44ecb0db4320c7b316fb1f3bff1d0b9730f85beabd680f4103"
  revision 1
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "f8655fffcbaa99f9f56aa0b38f905df20580d803d10b42911b7db65ea2a02752"
    sha256 cellar: :any, arm64_tahoe:       "a8e9acf5dfcfd562e3f92c4a81d1869c497919930e8212024c0fcd7ed094bdbf"
    sha256 cellar: :any, arm64_sequoia:     "243a61840ce113b7e4c9bb98cb16600783bdf46c5d2b8f5d2eff2a44002add48"
    sha256 cellar: :any, arm64_linux:       "cdfd04d2bd59ce8f28d65546904b463a98c39ed06d8d2d4ba96f1a44ba45555f"
    sha256 cellar: :any, x86_64_linux:      "165dc726c78e029b9767e38c138003030e4121034036a0b9c8c5c59e72d4cfef"
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
