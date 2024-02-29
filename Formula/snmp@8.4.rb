# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a74da53fc4b0b075cf762cb37d71b1e22c663c64.tar.gz?commit=a74da53fc4b0b075cf762cb37d71b1e22c663c64"
  version "8.4.0"
  sha256 "f81c0c45824bb2ca2aeb9a3a4a7cdef1fd3e0a5fa775477448aaabed81c9cb91"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 29
    sha256 cellar: :any,                 arm64_sonoma:   "eec7c32fc51dd00c1364c82a47216fa9b25e117c5e81d1ccb4ea44d1a4d7c455"
    sha256 cellar: :any,                 arm64_ventura:  "ebc1e8e13e78bdbae1bf7bb448b79cc23271a8e6658800d478f30d3e12783eee"
    sha256 cellar: :any,                 arm64_monterey: "c910f56b820c8c59c65d7618bbe7e4203a22f1900ddaaaacc9e4c59b8618fa33"
    sha256 cellar: :any,                 ventura:        "9a41e8470a7ae43ce463e2fcd7d9fd44fddaa185c9bbfe7742d5a1b597b56da8"
    sha256 cellar: :any,                 monterey:       "aec4322340994f0d19b521841829ea5ede5080bdc090e8cd8310feb059e75831"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57824d3d9e1f9420c2f624eed7a5d010cc865c4077406bf4ab4bafffd064458d"
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
