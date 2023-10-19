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
    rebuild 3
    sha256 arm64_sonoma:   "93cf13e3befe73e214b125e724040d09e11e3436a499329772153d18bd1db2da"
    sha256 arm64_ventura:  "c835510097d7fe1ec52e081b57550429d7c542c65b8e679552d84e7f494b5777"
    sha256 arm64_monterey: "2e790e695239d41b9a5297bca6686f391067997147e8ea13529eeae7cfd4f0c4"
    sha256 ventura:        "09118c251b39be8248111bb1010bac48f54b8fd0c3c682d5b864f7f8956f4431"
    sha256 monterey:       "a617f26db58a4a7f4e1ddf6060ac29182ed07abf0b5d2d2edcdea8653dce09d2"
    sha256 x86_64_linux:   "a84f27ee1e9d188234c90c2a548c8a96ba514da84500b02ce7cb4c08fda6929b"
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
