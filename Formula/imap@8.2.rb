# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/492f9c607a3e0ee258d1273fbc6d6da73f180e3c.tar.gz?commit=492f9c607a3e0ee258d1273fbc6d6da73f180e3c"
  version "8.2.0"
  sha256 "c5f4671519b9d0a9aa5d0af58664598ba1aabc2cf22475bc9df23814d16eab85"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 63
    sha256 cellar: :any,                 arm64_monterey: "5f8bfdc8df0b560615ae8e1eca1a288bf7d670855e5ef4f077454cfcf79f0352"
    sha256 cellar: :any,                 arm64_big_sur:  "9a4d92cf6c2d0c99cc83c6c2512c9ed07232cc55d77689cb3d9ebc6d84b3b627"
    sha256 cellar: :any,                 monterey:       "e6c68f8157fef27b2defa0cf3446c8c33021232555c883d068186659f91ed596"
    sha256 cellar: :any,                 big_sur:        "f09bf45b5e5e9c7a7716c6faf39f59bff293f70031c8d48b197fb895782d8d3c"
    sha256 cellar: :any,                 catalina:       "c3c1e67ec9d82fcdb9be77c06185f44cadd477ed299bd7d649e06b4a9abfad1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "22a780d1f9da4bba17f0346c3242ac92d94d2e73c968d3e7e2d5140d426a8467"
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
