# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/541ed65f675463aea6c6eab55de38719b2d10625.tar.gz"
  version "7.0.33"
  sha256 "44a0552346687dffdeabacd4f9e641eee84f2630e852ccfd44c49e0da2fa515e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_monterey: "de596a49be64c94d206cc9db8f646d83e206b605e720345fdf5b7eb0b198ddca"
    sha256 cellar: :any,                 arm64_big_sur:  "854d7c4e839e78235a95367803816e969a664785b0417bf134d4699be591d69f"
    sha256 cellar: :any,                 monterey:       "00bda32abbc401a11dd982a6f0c4141c8e3ba64cf8f8151e481a8fe5f01d99fc"
    sha256 cellar: :any,                 big_sur:        "e8d7db912c5d1b29c8f4116fc0b117aea3b3bad7100a0d9ff788943db720a370"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "181c1b626147b1c1ccd13c6a2188459af4ddc15c029c6db7230ae8a457c5b682"
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
