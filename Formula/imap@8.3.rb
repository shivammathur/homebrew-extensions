# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/eb7ec15a614c20a7af278b4d2f7aec4a73a06b64.tar.gz?commit=eb7ec15a614c20a7af278b4d2f7aec4a73a06b64"
  version "8.3.0"
  sha256 "106d9589cf1558209f16eb6b3f8756425dc04a4d121a5c2085f4af0a6ab2c97b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 37
    sha256 cellar: :any,                 arm64_monterey: "1fd6fffdaadf56892276cd2d06d9be8d1e4767d4ff6641bca76dab54d0b5c109"
    sha256 cellar: :any,                 arm64_big_sur:  "d7cbb5f3d0f8a3d4d58bee27af55615f96845c8228188e08bc84842c2a632109"
    sha256 cellar: :any,                 ventura:        "56f45b65bdf115d32b891ef76e152c2dd0fd8ac762d8e5c19090716bf2a006cc"
    sha256 cellar: :any,                 monterey:       "8066ebf7a250ecaf4876cfb0ac4b8b2666f2f8f27b1bd6310eca358f95235995"
    sha256 cellar: :any,                 big_sur:        "8544cb62eb293b4dd1c63604f425aae77de26ce76e811c15aff239402f24b9d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56ac987aaf8be4b56bdc8e4f625af316de77ef68f67598dba8e75245911e2a9f"
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
