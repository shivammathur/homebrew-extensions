# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580fe100065f1cd83ac2ad5a6254a1f95dde93ee.tar.gz"
  version "7.3.33"
  sha256 "c3bb3db324daed97e2c50f2755462df5b0cb4b912ab5b38c96dc6cfaca92475e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "a096409ba54c967874b4234544adce9a94f1a670c419a2fbd481520376f89bf1"
    sha256 cellar: :any,                 arm64_sonoma:  "e7e7a253d69450b1e43b0ca3e6481401e02ce5d7b20a27c3d2ac507967376815"
    sha256 cellar: :any,                 arm64_ventura: "d70ebde39246c840509902d5c38c9edfe22832bbac2c12fa4ed9b2b982537438"
    sha256 cellar: :any,                 ventura:       "63b42eb72b09459843a93a2d5275a5e61d7266f9b4018ffd09a50bfbf8f423b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f2fb12bc908123c3875e5f6e79ae2a4e7c0d48e0c717fcd898ac1e2f0ed190e"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
