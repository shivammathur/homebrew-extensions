# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3d7a7dc276f07e44867999d1d6e9a142bc15829b.tar.gz?commit=3d7a7dc276f07e44867999d1d6e9a142bc15829b"
  version "8.2.0"
  sha256 "a27a3844fd7b5127f6d5401cc4f1841d71414773d9953264dad9275dd835f508"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "ca1dac75f8ec45e822b6f4327836c70ad658554c132c549167380c02beead470"
    sha256 cellar: :any, big_sur:       "1c42f0f967bea3b10e343934e9940cbef2792d3a1b6e51a04bc522baa30e5146"
    sha256 cellar: :any, catalina:      "737e2276986ebc30cf83926d6e1ebdd6d113838e026f7c65618484a5fe95c921"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
