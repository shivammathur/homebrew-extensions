# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/789867e844dc0465fe01a703a1bef2a7dba0c62b.tar.gz?commit=789867e844dc0465fe01a703a1bef2a7dba0c62b"
  version "8.4.0"
  sha256 "50d54b44e79ead9c0d63a0224328a06f2988c82e73f0fb46b6aba3bc30463dde"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "374ba64e2b9d6e491e9e4052dd6d54d8334bae8ccc29b0f77642b7d619f891bc"
    sha256 cellar: :any,                 arm64_big_sur:  "a29889f0d4fc81513306ae72cc7652ed0131531f43d6ae56239b262f72343025"
    sha256 cellar: :any,                 ventura:        "05dee34de37d1fa9360156b032dcf8169aed3ae154c68f3f5163ed1473e9fdc9"
    sha256 cellar: :any,                 monterey:       "d282efe25d5dde23b33501d4a967fd96ad3c3dd15fbc58d48dd26142b036566c"
    sha256 cellar: :any,                 big_sur:        "b476abe430fa031b401acdbdb93c735e2013a8f25c867d53fce5f79ea976887c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb24c1e61ca4f25d4ea2c8304acb3e6ddc965e14d6371d7fca8b4ecc73c1fd3b"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
