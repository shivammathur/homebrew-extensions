# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7424bc30ea6ee2385f843dfb23f843b551008d17.tar.gz"
  version "7.4.33"
  sha256 "71139f37f15b8172db13fbebda91829c305d506787e0defd090044ce92c0231e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6e466770b2132638bf30cb91c72cf47fe48bf5fc1aa362860fc6d70a634d863a"
    sha256 cellar: :any,                 arm64_big_sur:  "1fdc694e9680a1fc3b1b41e629744168dd5ea7ac2544d19b75ab0a36e07ce4f1"
    sha256 cellar: :any,                 ventura:        "b83f80d8c541dded554349b65af4663229c0aac2bc9f166e5c6ee834ebce4347"
    sha256 cellar: :any,                 monterey:       "4d79053af38480ffe28dec5dddb2515b4adaa0f82e716fc3d0ad7d8036131711"
    sha256 cellar: :any,                 big_sur:        "86d34212bae5d88ec74738aa60a468dcc09336765d50c94327d4e29d9dbd8bc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b347536db31e00fd566ca86af84227ed88a9d9d3eba6dbfc8eab0fbf401c501"
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
