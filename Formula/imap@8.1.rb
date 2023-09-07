# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.23.tar.xz"
  sha256 "fc48422fa7e75bb45916fc192a9f9728cb38bb2b5858572c51ea15825326360c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f4b389e39947226fb4018480896eaba5d8415acda284ed5f91f479156bb98cc5"
    sha256 cellar: :any,                 arm64_big_sur:  "4ae7995e17f5f63eaf0d92f74ae578de8fd64c02d157886d4235cd0d53bfbec4"
    sha256 cellar: :any,                 ventura:        "9acbc9222280e785d92bb412c1281836b604700fba1269945ae8a46caff258e6"
    sha256 cellar: :any,                 monterey:       "426132e1591aa528d9879a0747e07d455b9eda8c2a9c9b945549e250cdc7b456"
    sha256 cellar: :any,                 big_sur:        "153bcecd940f4ba76d063afc54d0e0ed1a2553c6b53f91393ecfd4151ac5df0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b4198ced78d1abc54758697e9792696ff05997684f099619c37ec64a74d6d06"
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
