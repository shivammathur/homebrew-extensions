# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/63e20a2b1e62df7b5c1b6f4681944c767244299c.tar.gz"
  version "7.1.33"
  sha256 "74e61b77ee695dee97e8b4a5a3e24d106cfdb0fd0bd8bbecb34c0593a799b757"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "d9cfb87d6ce404e47a718dd210ce3a1d7d7d319ec22840f5cdc2d70d6bbda09f"
    sha256 cellar: :any,                 arm64_big_sur:  "9fa0943b9686ebe5b5597bb49d2aa9e708b751edff700ac0d695e2ef58241273"
    sha256 cellar: :any,                 monterey:       "be3de62f42deb6d41fadd76b0e318d31b6549a5480f670f964a011cfb1711092"
    sha256 cellar: :any,                 big_sur:        "d5d8bf29410ce1e6498ef181fb55ffd6b8df8789503322e4ac12373b97251651"
    sha256 cellar: :any,                 catalina:       "3216c1e97daca0da738d0f853950e3f6afb0584a5f5aad1aaf38581a1a15eae3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "10ca1dbbcceac338550c38f702e8f53e94a7f9e83bfe7d749bfa5329ee19a944"
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
