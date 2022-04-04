# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  patch do
    url "https://github.com/xdebug/xdebug/commit/06c7f670e78fcd7867daf30d10eff785a50e033d.patch"
    sha256 "0ecd654aa184bf5974532d107d92dddd4337bac834a1c712d2dcf73c3545aeb5"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "a31a08a7f91aa7e9ad2be0cd33223eae1afaf7b5fbf24a5a6d62c44d34c5fbca"
    sha256 big_sur:       "a1fc063ed5496d087cadea2ba559b9c2bc1aa41186d297335b0ec058150fb88c"
    sha256 catalina:      "657fb2268a6cf8d72bc65a5ef8a54d215aef7f2084e31032b067161434a9ad2d"
    sha256 x86_64_linux:  "373cfbcdf9ba2f9f51316b5d3e0b20dac2bfba70b64ca2eecf35d0e15d62619e"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
