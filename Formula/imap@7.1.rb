# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any, arm64_sequoia: "5453563f8b4c34efa30aa25d26ba0c7f75c7aae4034846f13881ed845ca4d52b"
    sha256 cellar: :any, arm64_sonoma:  "eb4930ea98ea0e043652b784ad538d06aac73f43b8f326bf03b458cd1625635b"
    sha256 cellar: :any, sonoma:        "50e70b5adc2ac59be725459ff058d87f811aeedfb53c428ce60ab860df637e2a"
    sha256 cellar: :any, arm64_linux:   "956623b709919611457d131a3a4765fd8dce082756421d63cd7106b0e09a0149"
    sha256 cellar: :any, x86_64_linux:  "a0416deab3665ea328f14990f2b90e4acb2ef9f82ece6844310b9ff607eda268"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
