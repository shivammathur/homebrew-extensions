# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-7.4.27.tar.xz"
  sha256 "3f8b937310f155822752229c2c2feb8cc2621e25a728e7b94d0d74c128c43d0c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "3a07ab7923d862a686c216cbb30fcf852f582abdba05bc3ae37aa80f3c0e0545"
    sha256 cellar: :any,                 big_sur:       "7056a6a4a49ad1b0106001e2e5395fcd3027e9bae745c4c8e7cdd63718758fda"
    sha256 cellar: :any,                 catalina:      "fdf378f9e6f94cc11b2c2ff4545bf54872b01acfd62fd05ea3b0af5ea924cbca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff4fe22145929f2bbcac772b2ea63939d3835d029e2c38f644d64f2e08bd860a"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
