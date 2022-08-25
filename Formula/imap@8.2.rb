# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/de90edc42c69d8e9670a2ed68cc16e7921d85fad.tar.gz?commit=de90edc42c69d8e9670a2ed68cc16e7921d85fad"
  version "8.2.0"
  sha256 "076c24025f5b2989a34d8aea0258f2e4fb10c9dcc409cdf6a42f77370da0d99b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 69
    sha256 cellar: :any,                 arm64_monterey: "b84944e4d491773ca5652b9feb4e1614f25bc1e6ab292c9bd6a34ed1ce48025e"
    sha256 cellar: :any,                 arm64_big_sur:  "ee5e2ef27c7662793dc3a29d08f1a2725d79215388834c402fc0490fbce83c1b"
    sha256 cellar: :any,                 monterey:       "d0a01f2e1cd103fcb8300d1775eec361193cc021a5e0bd68f9f0059c18e57d16"
    sha256 cellar: :any,                 big_sur:        "89a546e83f62169169f0786e60fd9d6ccda10a896a4e50810c5a4b8467da539e"
    sha256 cellar: :any,                 catalina:       "604e081a8d4b997063de0a3ee66e8571a62bfe7cc68372abc94f17ec38d241f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50b4773135621393a2c710f15b77a69a5d9e5e9618f6a455c519cfda16d67505"
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
