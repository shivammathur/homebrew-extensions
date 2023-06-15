# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0513eaaeb6c03e282cf8c13352ca590428bfe127.tar.gz"
  version "7.0.33"
  sha256 "2289f0d30a7be5e556f9ad7804f9f4102abdc40df1d454ecce2fa2cfd0924b71"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "e31c4dbc47ea2b49b8102e98c62e90cb2baeadc4a7ea5226e5130dad88668109"
    sha256 cellar: :any,                 arm64_big_sur:  "65307fe021dc8b9e9ca60b1bd21f6eff0d149a1c2d3beaa3903e30304b6d9bb2"
    sha256 cellar: :any,                 ventura:        "8866f91fccecd44498eb08be597654a7f097402ed37982364cc58df558d1d6e9"
    sha256 cellar: :any,                 monterey:       "c389886a55862f1e4b30a257eacff485c10d22aa057de75f217642f2ddb2f4c0"
    sha256 cellar: :any,                 big_sur:        "419bd53dacad4fc6fd4bec1a0e72f92b083aed918fa8906ea3cbc5719e2c8c61"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ed6107d06b3ddcf59a1136bf3e5db5c9e08768d1a81fe7b568b3af0c1a3302b6"
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
