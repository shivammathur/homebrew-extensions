# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/282655083ebb4980826253e2b8e3d6d2d2901ff5.tar.gz?commit=282655083ebb4980826253e2b8e3d6d2d2901ff5"
  version "8.2.0"
  sha256 "154eadfebf2fed80cc4263488612e001b9b3e5e14113649a6c2c341fbfbd3f1f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 50
    sha256 cellar: :any,                 arm64_monterey: "f8f6a6b9f1dfda16b9a8d8803fbd74ae39ed8acd9292ce00c2cc962af768f03c"
    sha256 cellar: :any,                 arm64_big_sur:  "9948f98a3640b16f8d1bba9b0c9027eb3fdd298407a94385d3fa8d8c60664938"
    sha256 cellar: :any,                 monterey:       "f929e91191fa8b582dd2ca1d6297d6a63e30f2ebf85d2beb78b79166bb9edd1a"
    sha256 cellar: :any,                 big_sur:        "f00a9f1bdd1c726783bdb7bd6b0f4c1260658f1a012c02c9965889e14da9df84"
    sha256 cellar: :any,                 catalina:       "99b67c498db81974ec0b80c99a8834cfa63e58f74faed9042f6940adef4cccd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2eded81b2c612fbce01a3c9554650eacd5e8747ac62379da7d1855136f64bc5b"
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
