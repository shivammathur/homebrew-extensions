# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/706696f2c03380d20e999a96089a476ab8cd0e7a.tar.gz?commit=706696f2c03380d20e999a96089a476ab8cd0e7a"
  version "8.3.0"
  sha256 "d927c2bd6045ef16b51d7e0ccdbba0afcc7e9a2ce777567a8bdc9ca0715c866b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 31
    sha256 cellar: :any,                 arm64_monterey: "348c04874490ee4ed2d67ddccc0fdea5bd175fac67ea9d883b6db44574d73ac1"
    sha256 cellar: :any,                 arm64_big_sur:  "d485a062ff59d01727e581fb7c96236d2da17b8530edf7a59ca30ab7a611bae1"
    sha256 cellar: :any,                 ventura:        "319bb6ae2cb5007c678eddd73a4530980c98b95ffe957a21b115809f619c86fa"
    sha256 cellar: :any,                 monterey:       "8f0e8e9bca83c1d0f0016acfc81bb41e9f56a92b126133577b005025b66af225"
    sha256 cellar: :any,                 big_sur:        "735ab792bd571a6ea50752056fea503b93bb17e5d43a75043cc52f4c0c0396eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b745d7a7c9e92af8ffd1a6838ee120d990569693c11f3f119029a25bf25dfce5"
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
