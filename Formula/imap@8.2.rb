# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/98c4a42b515a93efda58ceac39d8b531df7f349b.tar.gz?commit=98c4a42b515a93efda58ceac39d8b531df7f349b"
  version "8.2.0"
  sha256 "cba49a88f8f12faf90209dfaf982fc8d909731e932b9c31e413d9e4f81e80e3c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_big_sur: "bf2423873021475a02ae79d19ad079c77f4eb7e006ec0d4bfbfdb13e4b7997e7"
    sha256 cellar: :any,                 big_sur:       "2364192728b871824f7c3b1830a5c3d68319de2471b82896c2254d205a9c382f"
    sha256 cellar: :any,                 catalina:      "46a10b49905d882631ccfa9ec052fbe8cb60b47f1effb76f5488ad35cc0fa4f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c2ca178f98308178d16ada215d635be08b985ada8b78ddb03d58010f016b6a6"
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
