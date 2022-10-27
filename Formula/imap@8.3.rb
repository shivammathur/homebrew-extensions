# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6d298cc784dbcce3a051b569a09d47cc1bcfc0e7.tar.gz?commit=6d298cc784dbcce3a051b569a09d47cc1bcfc0e7"
  version "8.3.0"
  sha256 "a47015fcc3ad2d30d647ebb50de02b120756269f9e91a05e3fefaf4669b84306"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "3b291f7270a16f8482ba49735b810b8522140a0c90f669fab60c899f4ae8a081"
    sha256 cellar: :any,                 arm64_big_sur:  "8c3fe9b3543d87e6ed4f02afa8f9b13518167be5ef22a0e2d7fbe0590260666d"
    sha256 cellar: :any,                 monterey:       "c4fac2832fec34bc6c994df3e2f19db7db59cff951499f5d7e394d7e2834835e"
    sha256 cellar: :any,                 big_sur:        "8b96e4155b2ed82ca8d1354387751353dbd8ad2b640e7a38e727efa09d575c26"
    sha256 cellar: :any,                 catalina:       "fdd6a31c6fb2b4798cdebda7dfbb68e70098121b28b086fa5e40cab70864bb64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60166b192c16191e0699d0e2b3617033bdaa910761638df546d7fd20ec60e48a"
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
