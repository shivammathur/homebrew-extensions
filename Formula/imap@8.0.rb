# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.0.26.tar.xz"
  sha256 "0765bfbe640dba37ccc36d2bc7c7b7ba3d2c3381c9cd4305f66eca83e82a40b3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "926cfc5a475755ca9f435c4a9ee81b7306023f2898c5b8791d45a04bcd0fe7f0"
    sha256 cellar: :any,                 arm64_big_sur:  "4e64c78d31dd854e843d13205e036c8473a5d4109c0e5d4cb58dfb5a192bc7be"
    sha256 cellar: :any,                 monterey:       "41bba2ac7fda7eb313dc131cd34d9ffe3579656ef7acb65ad8e1ba503fa3312b"
    sha256 cellar: :any,                 big_sur:        "e64864cd9bbcf00941ee17417158b83962d7ae76a63805d94f5153915cfd21fc"
    sha256 cellar: :any,                 catalina:       "0e1af4774e6917066868185df2eaf4c826165b5bf489968b5037bc18ba56ce7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6083176f29fae9dbb8694a68123f6dc6ad34db1c98d41a914565baf488ed92a0"
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
