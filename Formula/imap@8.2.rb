# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/97cdf62a6a1d8491f8d1ef1580f344400eb51f1d.tar.gz?commit=97cdf62a6a1d8491f8d1ef1580f344400eb51f1d"
  version "8.2.0"
  sha256 "ba9057e0c070c3eb933784d1a0e6485b0a99e945ebd55e1dc455fa963b665acf"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_big_sur: "f29c5204089a9a929cb78cec1c3594950339ad390465d7f749f67405d293bf3a"
    sha256 cellar: :any,                 big_sur:       "73e4f9d13613541173c13d84ebeab7acfb83ef0b55a91e9c3698fe0c08f03c8b"
    sha256 cellar: :any,                 catalina:      "92b6c0322d6ea2bf506dfbae60fecfa4d6e32c7294cf5660d794f69d88c38ca7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f105734eb95cf6117db21c69fa8d95050b9d15a4834f470cd1979913ead23e29"
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
