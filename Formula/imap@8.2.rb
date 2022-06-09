# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c83b57096acb6fbbb49460983c26029583458470.tar.gz?commit=c83b57096acb6fbbb49460983c26029583458470"
  version "8.2.0"
  sha256 "2ce7556bf2b8f4f7d448faaec38188367832df26f0713174917b247e15215b4c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 54
    sha256 cellar: :any,                 arm64_monterey: "806680f72d85d602deec645688dbe02d91a58ca918d4adb30debdd3ce20361b2"
    sha256 cellar: :any,                 arm64_big_sur:  "08ce0dbce7c85ac2bf9af40bae877eee919618c30b3be0d30df588bf0825fe2a"
    sha256 cellar: :any,                 monterey:       "9d5ce735f2836018ec4b5c6593518c313cd1dc321f5b0b2b46491694b0b4bc2d"
    sha256 cellar: :any,                 big_sur:        "759b5b790f558bbd64bbfb39af14a68637673a773b13ecdccb7e83969617c5ce"
    sha256 cellar: :any,                 catalina:       "5a0cf48440faab86f711f56543a526647e132f60783278ae852425e44ad68975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a42440c78ec60ae4b4bf5aa49287d22ceebb2622cfb994e718455e71292daec"
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
