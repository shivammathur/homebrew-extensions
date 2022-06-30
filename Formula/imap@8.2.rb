# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e2bd3b1e999b62cb0b6135f7c6a5a237a1200077.tar.gz?commit=e2bd3b1e999b62cb0b6135f7c6a5a237a1200077"
  version "8.2.0"
  sha256 "94a4aed76bc77c13aceaac454b09612625714cd90b791ebe4f9df0b0a01dc28f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 59
    sha256 cellar: :any,                 arm64_monterey: "46da17794e8db3fac4c8c17c2d43d88aa275542b4812772dcf1f6238362082ed"
    sha256 cellar: :any,                 arm64_big_sur:  "b6fd862ec489af31f00490a04b021af837ffb06703a38893006e21de0f73362a"
    sha256 cellar: :any,                 monterey:       "648ce372c70e180485c5a743b93ebd62c9021f21bbbb83761c854f99d584eb57"
    sha256 cellar: :any,                 big_sur:        "938d972bb88661f44e844a4e6b2f8a332eccdc59f70b6c1f1fff0114e2b03532"
    sha256 cellar: :any,                 catalina:       "a70c278d889d8b1dc76f5b791bcda01f95b0a1b7b21a634f5c1d7a530275f501"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "91156baa36527eccf127ef753dadc057ac4c788cc28ad32bb1cc2a7b7dd507e8"
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
