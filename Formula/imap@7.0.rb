# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b4b2a32c497aae31700c21dfca115133116b9ab8.tar.gz"
  version "7.0.33"
  sha256 "d989743746a1ea4070b8ee794c368a81095984cadbca21a44d64ae76b6f8a9b5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "55c81f15f67b7d091a25c319f81d568dcf4a98412a9b693da8025506baef8d9a"
    sha256 cellar: :any,                 arm64_big_sur:  "0e5623d7c7136032b649b023bd3719a7aa91293ebe4c864762782fecccdbd9db"
    sha256 cellar: :any,                 monterey:       "b1ed049455515ecab070598b2204c2965647bccfc21be44232510c1461b22929"
    sha256 cellar: :any,                 big_sur:        "540b0b05b67c4c0d509be9d301ed82f5f10416a8295d8293e6657de60bdd581f"
    sha256 cellar: :any,                 catalina:       "7b9aba8c90308f1e9fd63e364d581bddf16ebcd40ca5c23e25696bb99913027f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c898899fefafb90eea070090c33a17fd1048d1bb92f23ed0b1648c890fa2569"
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
