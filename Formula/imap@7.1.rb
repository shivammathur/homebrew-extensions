# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f12d05c0fdf5c88c94d8d54fa1f925aae6e302a6.tar.gz"
  version "7.1.33"
  sha256 "3153fd11bee1ff291c9367c9544f12b3df2070bba97420a12c835505ff7000ea"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "35d903b89aff01f04c20e84ede8ab2ddd27598a8dd703cba87930b9dbb5a1609"
    sha256 cellar: :any,                 arm64_big_sur:  "e8a4251c8b8163ed96c652b95224aa254c17521f5eed9a20d4dbfa8a82b70409"
    sha256 cellar: :any,                 ventura:        "97d4604d9c1a2214c22c8f883e575c6621e71c484bd4bec69a5a2f047593f3e9"
    sha256 cellar: :any,                 monterey:       "761584cf4fdc45f76ea6508e75208fc41c1a7c6b238682325295e51cb3c3d053"
    sha256 cellar: :any,                 big_sur:        "f840beec23a21b3ee99ef2744630d1d7e9ce30ad82bc7b9544c0a6a5105a8697"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0beecfa716264504d1db3a726331066cd5ca17b850636f8031ea4396ce8300f1"
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
