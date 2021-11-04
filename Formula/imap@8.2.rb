# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1de405907df74424819aa24af1412553df8d403f.tar.gz?commit=1de405907df74424819aa24af1412553df8d403f"
  version "8.2.0"
  sha256 "3a0f654a95d9f8f53df2ff833ea5df58308ed3e4612e44bd7ec1e954299e5d4d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_big_sur: "891574cbd8bf778bef2236ea047b323d84b520a8c9367f01c16188c682382531"
    sha256 cellar: :any,                 big_sur:       "4726328a3343c5670e40301a2431c1f4a2e0eba5788774b5f66e31175ebc1f76"
    sha256 cellar: :any,                 catalina:      "0e08ba816cf248e20f2d68b06ff7aec3a06e21977f225f1008b183e5dfd74932"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82926e213241fd42590b3f518132f3f52a16bea37a5262273917b8012cb4ebce"
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
