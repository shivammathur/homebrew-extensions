# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5c2bb2fdf8c4b95523ed2b5ffbdf565fa73ede4e.tar.gz"
  version "7.1.33"
  sha256 "819e7b0fcb1ffc143656a0872f3a7668e4472170fa91495f6aaae549dda5fa07"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "25cca60301fdf233e2a23ab797f8447bd432dda75f6ae46864483fa9f8cd1a5e"
    sha256 cellar: :any,                 arm64_ventura:  "112475699f5b4e0c6dac91ecc5dfdd92abd25cccebd3fe532a37f919ce183daf"
    sha256 cellar: :any,                 arm64_monterey: "996f12a655dc60fb27eac72cb99c4d3ee788feaf57df0745876b5271c0f28652"
    sha256 cellar: :any,                 ventura:        "730d0063413f4aa4e3e0b9e23e4291f1c00992b0ffd6208109d33c0e62dba01d"
    sha256 cellar: :any,                 monterey:       "4c283bc4ccb1cc3f58f8e24f607530d102e471b0947ce0c0ba58bb0029b002cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "47affdcd07574f7903cd1d12dbed8b96599f4d6b736073f4b40eb35665f7f5b3"
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
