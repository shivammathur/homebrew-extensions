# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a0ba10436c16452072c045bd74d0a9c27b92606b.tar.gz?commit=a0ba10436c16452072c045bd74d0a9c27b92606b"
  version "8.2.0"
  sha256 "b8cf6b53ef93b642067f03dec5454d634af7dafade258c311c930330bbe4a345"
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
