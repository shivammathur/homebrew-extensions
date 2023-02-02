# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/fc84c778aa61f1eef337532f2b838413bf1ed651.tar.gz"
  version "7.2.34"
  sha256 "fe78092a1bbdff097396fc9e80c34f26bcd7d58d427ed99de7dd06b35d8cd94c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_monterey: "a487b0e1aff9f8d79b6fb66b96dcd13716ff230b8aedf618f96781d8235ed7eb"
    sha256 cellar: :any,                 arm64_big_sur:  "434dbc71cff2ff3047cf3d04f486cd3a4a8457ffe2a79a343ab53f83781a4dc5"
    sha256 cellar: :any,                 monterey:       "f5c79027887e722887a52572d4bfa11eb888d437848f6b562c7f60d295a85155"
    sha256 cellar: :any,                 big_sur:        "63a47203a169c94409d085ade14c42713556e4188c2a1e4c40d6816a2dcf1569"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23fc4cef163da40e60ef0f7131d7b976feca7c393befc7e952d3ae79756dc855"
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
