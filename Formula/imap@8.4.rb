# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d693f0a4dcfa41da5d7b2c65dd8d80c078c59808.tar.gz?commit=d693f0a4dcfa41da5d7b2c65dd8d80c078c59808"
  version "8.4.0"
  sha256 "b27c295dea832bce68a5e3151343b9151de45790915789fcaf03496fd04b3e53"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "28a4c434610aa26713a1d5396e637f812b9ba464ee5fbdd9eb23e1f67e609f83"
    sha256 cellar: :any,                 arm64_big_sur:  "770b9616012a01bb7d487cc89ffbec6e9e854831eceae3a619297db677a40dab"
    sha256 cellar: :any,                 ventura:        "7bf0b7fefdcbc52bf1e03443cccab102d86d49beee56b8536fe2dd23ef69f14c"
    sha256 cellar: :any,                 monterey:       "9436d93d58ad6601e06aa73427f40c7674820806d6d75bb2b99cc9ea4e4d0fd6"
    sha256 cellar: :any,                 big_sur:        "040ed79752d373cc33cb5d53705e750045940d469941448d91337f53dc96d5e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "75e876e7a2caadd52a6d7b1b0578a5414221581fe78d38af8530e71da29a20d4"
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
