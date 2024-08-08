# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.10.tar.xz"
  sha256 "a0f2179d00931fe7631a12cbc3428f898ca3d99fe564260c115af381d2a1978d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "2988ea96a4bdbae65425e0cd7d67e5dbbf16ba5c355b6cba8ab42e29235ba995"
    sha256 cellar: :any,                 arm64_ventura:  "697b159e84a1f7c0d32ed8d58743388cdef34cd5fb74f7dbf3a1d0acb541464b"
    sha256 cellar: :any,                 arm64_monterey: "b07da7152e0ac759dc80c1652b8c3b312f52b658d57f272972d366c8129a2ffc"
    sha256 cellar: :any,                 ventura:        "f0e96cb63ca0f3177465d7702abb458a515a077cb1cc5285a4e302d5af7ceaa7"
    sha256 cellar: :any,                 monterey:       "8e0a5c3aef2af8e8f2f9c4836163489b76229c9bb0d10d36d8b45bf7e5eca083"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f35314d9fa57958dc6a136d4673d89bfef19bdeb4ae73b1a98afa339066e3966"
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
