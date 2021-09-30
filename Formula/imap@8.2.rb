# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2f2e10f55356800a8358b5d2ede85e29ea8295db.tar.gz?commit=2f2e10f55356800a8358b5d2ede85e29ea8295db"
  version "8.2.0"
  sha256 "c3b4bbe8a12aa3f5f0f8760f967f0b6511a891714e4cc374ac5528f593a48702"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_big_sur: "4f7baa9632447ea63b87994d2c7fd501aa72c1989b557c4b65e1f072ce36a5c9"
    sha256 cellar: :any, big_sur:       "e926d054a41195879c97fb62026a01811a46e532a1e54434e292715f414c452f"
    sha256 cellar: :any, catalina:      "be8c1b767c8818146671fc808dd0bb9448351a9db66f86347573f3e2963b1a98"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
