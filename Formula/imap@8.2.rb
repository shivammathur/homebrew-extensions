# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7061c40f43ad5bd5c6dd4b68bff182a4f35b122e.tar.gz?commit=7061c40f43ad5bd5c6dd4b68bff182a4f35b122e"
  version "8.2.0"
  sha256 "f6bcaa3f05b808bef3869bc90e4e370821cae21f26abef349c30e129411e6d28"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 47
    sha256 cellar: :any,                 arm64_monterey: "e900e182d6b8a6dd65c219f506a03069f56f7cd22e0a343a98101ec40a820f20"
    sha256 cellar: :any,                 arm64_big_sur:  "60d02ca813e3c3bae92741d0fbcad5bc6ef0798e80f25812eea6b79eff241481"
    sha256 cellar: :any,                 monterey:       "1cba99340f9fd5f2e8be96b2e449296791c401da57b57145c12afdae0a94f409"
    sha256 cellar: :any,                 big_sur:        "93c0faf23bd1369ed00addc24d648a870370765763b03e57d9534c96864035f5"
    sha256 cellar: :any,                 catalina:       "ab6ef4376deb8ba38a881ce66cdfc7fd19d00ea0cfbe273d5324c1dcd3658e6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb5e2368fd351dfb8fe0266595b655dfac2b3b606482d255ca106e8ac8fb0f03"
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
