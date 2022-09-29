# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url ""
  version "8.2.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 74
    sha256 cellar: :any,                 arm64_monterey: "7d145ae52dd6488414405aaf3a7085f4b788ca6f0b46e2e3f925501ad9d46ffa"
    sha256 cellar: :any,                 arm64_big_sur:  "cf5b64ec7371053b7fc28b7ed0bf77b626313ce2575c602ca99be48904f1831e"
    sha256 cellar: :any,                 monterey:       "36f99bb105d349c56ecd6377a401d549c68ae27524497b366112f65f7891a1cb"
    sha256 cellar: :any,                 big_sur:        "c0a1b677cf5098a4b60770d80f8c3a9e2e97ab8ab0c20e55f2b825990078344f"
    sha256 cellar: :any,                 catalina:       "de476b973023e449dc58d225ecb340826d5904caba471852f4b97d3f4cbaf15a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa9242e0e395ee642cea93d8c504f8b34eb4abb8686333419b768bf5a7ed9108"
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
