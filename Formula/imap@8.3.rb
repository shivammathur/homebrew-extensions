# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fe6263e2437b312f9a8b685013cf194f31238a38.tar.gz?commit=fe6263e2437b312f9a8b685013cf194f31238a38"
  version "8.3.0"
  sha256 "737465e6ce4872bd72d32622f6ad97b92b9f9fcdee3dc77b8026b5a4946eec8d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 41
    sha256 cellar: :any,                 arm64_monterey: "2a02f1f6a8f1cdd64a0b724755c828c672c4705af5366a36227a085e84953371"
    sha256 cellar: :any,                 arm64_big_sur:  "ad85b31b1ccea11461de3bd6be2f95eade3ecc8e289202d42308de40516c45fb"
    sha256 cellar: :any,                 ventura:        "1b8c94724dc57b542451a3026cb1e113a3e0dd425702a9cf8129bdd9f1950a63"
    sha256 cellar: :any,                 monterey:       "257c0a123943d819460becf612070d549d36c2de077162995d60193b54fe9b7c"
    sha256 cellar: :any,                 big_sur:        "e84519f3388c72b41ce06abec3c04130ce0d8f3be7e3cf9701024a6c1756cbd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "759f289407b2c3bbb89bc544651c6446b1e4cd0caa05774b1d839118b15239c9"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
