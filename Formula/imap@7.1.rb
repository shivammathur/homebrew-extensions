# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "8556864acd4a0aec1bbf9ffe6ee1ef0da3576db7183e87b95efe43461e742a9c"
    sha256 cellar: :any,                 arm64_sonoma:  "0c29b5f8ca86e826078370643ff5e0ee884b7a31ba1beb28d06760ad8cd6500b"
    sha256 cellar: :any,                 sonoma:        "e40eabe530f3f3c5173423461dd46efcc6524b23e6ee33980f0bdb89736eb92d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "115db7b7d695c5d83c0cb5efb14a43a5fd03a8b19204ce9e7b3b5401187eab4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d957a3d943e380b185df67bb21eba5a42c7891099d45c4069c7f4f015f9b3415"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
