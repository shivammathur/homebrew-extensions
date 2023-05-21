# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/548e0615cdfa3f13e51c07e95cde0b20de21c877.tar.gz?commit=548e0615cdfa3f13e51c07e95cde0b20de21c877"
  version "8.3.0"
  sha256 "c44d2171c19d9076ee40ec2a51874750522c0c800635267ce3cd0b7c41d82f61"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 36
    sha256 cellar: :any,                 arm64_monterey: "02bba4239ba0ea5919eb6e65f9c3bff21cb7900bede77e5fe68402ada0e22dad"
    sha256 cellar: :any,                 arm64_big_sur:  "6b990c660c68b57f13df508daf7cbe17c18d44ee8c38ada689a5cd08b3bbc775"
    sha256 cellar: :any,                 ventura:        "f63a4ab800ad44963e4a6f061ca4fe9cada4f5dd008c4eb9b6f97dbfc6907ccf"
    sha256 cellar: :any,                 monterey:       "7ae74bfefbe86a7b975a1246dafad8963965a97bda1852e2359456406ba2c870"
    sha256 cellar: :any,                 big_sur:        "fbeb7a9beb74df77ef495ca65dc5e25363383dc5cb8d9bac88584a76f14876b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9f8d571628ab7ab66edde7aaa00bf81b4665ae92008037def01fcb9e017bdf2b"
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
