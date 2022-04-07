# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/411706382425a7ddf6aa1b44e1745441add9fc9b.tar.gz?commit=411706382425a7ddf6aa1b44e1745441add9fc9b"
  version "8.2.0"
  sha256 "64a1e935fefeab530e1470f8ecd3478b9e2443f5ed9b66326a58bb8e965b3437"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 44
    sha256 cellar: :any,                 arm64_big_sur: "740029eb5f75619579d1ede73c49ae127b1f38c1c2491ef806fb59c08c19cd67"
    sha256 cellar: :any,                 big_sur:       "dc1af68e361e5ecb3d3d37829bab78ee06948baa56d735541222273c47372442"
    sha256 cellar: :any,                 catalina:      "4f37cf4a08ffa41ff633fa4642599b4956ff1437a3dd7a1bf5e80574bc56db99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eece4258ec8fe0fbe733ef65c4d01e4d8788154de087ae7a992df9910137710e"
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
