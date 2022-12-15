# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d4ca691b6d9f309b8bf22a55e423d2917f765b8b.tar.gz"
  version "5.6.40"
  sha256 "49dc98dda388ae99e6542b0b6d395c13b58f0b35398b61d0860315e8b1e54988"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "c3780c3f1de3370b7502a2fae60610501eb1abd722e634822aaef236a957ac1f"
    sha256 cellar: :any,                 arm64_big_sur:  "94433ec941e4b3d9f5c61324d3308657249be1aff8f2dd1d4bd2d5d56633b049"
    sha256 cellar: :any,                 monterey:       "84cbe9402d382281f9377ff2a8983a1b5561d45b850a223e6b20be3c049bda3b"
    sha256 cellar: :any,                 big_sur:        "58e4371f913ba422b1a3c149de41b73f969453bac778cb650b9a9fd68e999465"
    sha256 cellar: :any,                 catalina:       "6fdba4e66922dd3bc4d7ce921b30b6a916a59abb154b16e5d08d3a198b7dfaeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c856d6d1f955fa00c9711bfb02787679fe064866238c431dc8646f03dcfe952d"
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
