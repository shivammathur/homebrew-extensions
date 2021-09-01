# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5764414eb8900ae98020a3c20693f4fb793efa99.tar.gz?commit=5764414eb8900ae98020a3c20693f4fb793efa99"
  version "8.1.0"
  sha256 "723fb71e7b67c7ebddfe5f741c594b63a11c3f84f02cbbc4ad5615047dc275fd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any, arm64_big_sur: "662b3eab07a43cfc24d2bba00f2b3104ed673d93cd92611706f862e87e74bcad"
    sha256 cellar: :any, big_sur:       "97b488dd073fe5aabb095d68c91902c7e3eb6962eb8d0bb68fbce1d8e2fe97be"
    sha256 cellar: :any, catalina:      "6ebbe32a344aacafd1f400afef4106325a342da20a54a518c4a7069a83d23762"
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
