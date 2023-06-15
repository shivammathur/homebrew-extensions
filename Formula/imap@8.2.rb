# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.7.tar.xz"
  sha256 "4b9fb3dcd7184fe7582d7e44544ec7c5153852a2528de3b6754791258ffbdfa0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ab2054b021b657b5afd9e0837a9f54aedea685cd778f05e09d536efdb2b70bb4"
    sha256 cellar: :any,                 arm64_big_sur:  "729d228b7e0d8cb046be414f8626d4764194d49f9d4031b53e82c9659ef29659"
    sha256 cellar: :any,                 ventura:        "4a3e2ababafab922176edb41be3035d13a8fbe420dcf25f0507f091e9c1819ba"
    sha256 cellar: :any,                 monterey:       "4d92431ead068924167b1e35e829df93ae4b793ce52fff3854b0239ba1ffcdbf"
    sha256 cellar: :any,                 big_sur:        "7eed01b2862c58ae27a6af3522d2edd72d767ec3b01a2a5d23a86dcd76847ed3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1229fbedf50472359a3d4b28b88971731f7eb8ee35aef4663bcc32848d918a7c"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
