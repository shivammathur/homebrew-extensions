# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/36486106d99fedca4c8938f8629742835269f477.tar.gz?commit=36486106d99fedca4c8938f8629742835269f477"
  version "8.2.0"
  sha256 "07318558d24faa8258638ba85a0e435103ecd3683c61e4e04baabcff06b6919d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 48
    sha256 cellar: :any,                 arm64_monterey: "965d9c1402be4b44f6599d59c69158a72718ae245143b6dc1d9b0436b84a912d"
    sha256 cellar: :any,                 arm64_big_sur:  "4b6233717c12a62644bf7a323b62b5f5447678ae1b4224f20a12b43fde1a801d"
    sha256 cellar: :any,                 monterey:       "fa7175c7d0f07271d037d37284e4f70e11dade3aa4437a1aea351edb1a751611"
    sha256 cellar: :any,                 big_sur:        "d41877823e0431b6e3947888f7a53fe8af4f014329f3b413858c6f19a03e78d6"
    sha256 cellar: :any,                 catalina:       "6777e53e677e885ec1f548b60479f1308f2afd3f393d39ef5e5eaf5a205dea67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e04286f7fd7a3388d1b736f0151bd64a92e1c08fd7c09f9b659d69511782dcb4"
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
