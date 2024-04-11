# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/55d42c0821d426b22eed16e07339fed20cc130ed.tar.gz"
  version "7.0.33"
  sha256 "d8f0f03a149d5534b75c7a144ba06fcf3717a9bed1fb2541e6972534fb15e884"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "3e78bede9fa5d35943cff705befe642fe9b8b0107f5903a67fbe76f288e0b6f3"
    sha256 cellar: :any,                 arm64_ventura:  "33a43a0958c1614ea28d3803c425320928333ab4e9d7975a6b36e086d0519b27"
    sha256 cellar: :any,                 arm64_monterey: "a36dffc4344f8ef8c262007edfaf0d81421807b74f2308cff1e7725617b5e7a4"
    sha256 cellar: :any,                 ventura:        "3e2d91703dc4159c225290b5e5c8a5afcea139bb896be8ff72d02dbbf8fb285d"
    sha256 cellar: :any,                 monterey:       "de6dbcd43f060d4c530d4c8e1cf21316e750fa604fb4f11a648e11148228e262"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "93f8c933bf16a3eef150a450b4e2e1148c794fd198ceb16bc976b965295f4e92"
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
