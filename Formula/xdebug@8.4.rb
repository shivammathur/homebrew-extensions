# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/68342a73330c1c3ce13e054a1964fc56fb94c9e7.tar.gz"
  sha256 "dca0793f47f0b04e248d2df1a6d9c7330a2392fdd56b5070b66680c4db003256"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 arm64_sonoma:   "7d1aae35385d8e232ed012007461d0bab50ac8b9bf58ce2324d31895f0916f4d"
    sha256 arm64_ventura:  "a587376f07f60d3331e92efabb6c6f5a02d4f2aa32ba5b8580fe9f45d235fe8b"
    sha256 arm64_monterey: "eeaa5560b98ba24913dbe59154333e60626b45b4c90bea4d616ab5d5a21613c3"
    sha256 ventura:        "c25f33762c3b752d0393614f40691975acdbeaaf20b274608e6c16e941a15516"
    sha256 monterey:       "4ae1a67df2f56501f5e1d0c50281f80818f17a7a40fd56047aa8fedbd4b8dee0"
    sha256 x86_64_linux:   "a17d722fd2d944289e79b9dee58dfaf11cf7ffc8cc5f4fb0fe2c1e578105dc4f"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
