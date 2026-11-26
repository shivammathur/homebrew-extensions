# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5d85325de4b739456646af9ac824015bb250b293.tar.gz"
  sha256 "03b3915a8a35907eac68dd93013896677fc73c23f70cd538fdbd477098bd3481"
  revision 1
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "6ed4cd153f7a5410ce8532d43c5ed87acfc741404287c21c378a10c3cc0b7d93"
    sha256 cellar: :any, arm64_golden_gate: "ac1f926e38b62e46b61a7d2e0350cea5a196218a78ad51348ea4c3589203d6ae"
    sha256 cellar: :any, arm64_tahoe:       "18a7375e65c682b88ce5d80a1841ff286260cb12b95c8393ec7170573a52f7e9"
    sha256 cellar: :any, arm64_sequoia:     "06223adba89497a1a652f802f6e400d6523613ebf52dd03e4efca39d166c2098"
    sha256 cellar: :any, arm64_linux:       "b97b8c9eee93dc042054f5ca3af965e7d1c04dab4bc9994c2d190f994f691821"
    sha256 cellar: :any, x86_64_linux:      "1ab9a550cfb425cee64f33462e7aa43ffbbd2a9738ad1500f54dd5910544c052"
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
