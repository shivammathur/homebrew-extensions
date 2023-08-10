# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.9.tar.xz"
  sha256 "1e6cb77f997613864ab3127fbfc6a8c7fdaa89a95e8ed6167617b913b4de4765"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b436a4949e93eb132a15bad4f9b7a6399e2c6ee7e8393db3429157a6e990504b"
    sha256 cellar: :any,                 arm64_big_sur:  "dddd95a9aac801aa44918b01566aad996b327214856d1a1d1e8f0a3067eb4f72"
    sha256 cellar: :any,                 ventura:        "a2d366f7f32a7c49f674033d7947e6a0126be46b594e63b80c0a6de7d41bc0e5"
    sha256 cellar: :any,                 monterey:       "71275047213f8f425014b7289ee3f22e4d8d7bc9c3bf3c91ff4753dfafeb06c8"
    sha256 cellar: :any,                 big_sur:        "5ee1cf3e345543496b6c2b43ad86d6c946e6f69f055466bc0154776210a27ab1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6cc359399f6a018be8ece074ef63ae7523cb83a3e9c691912049db467ee42cef"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
