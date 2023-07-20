# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "b0fb5f38c3f8589ead0942de6b9891e0bd084ce675ec8126e0da1d5956dba7c4"
    sha256 arm64_big_sur:  "ca6d45cb1b8a627dac2d207603bff52d15e20ce9c69baa7036153a718ea259d3"
    sha256 ventura:        "32b543f9a2365e5b9c37460c8ab52a739a71cf6fa692595531e6cb150ff46a5c"
    sha256 monterey:       "42b14cbe70d897ba5386f1825f07b62bc96b175063f99f6fc11f331e427780fc"
    sha256 big_sur:        "24f50eb031511f9f03a103099bed34fec86e76765ce7395d8397eca77fefbab5"
    sha256 x86_64_linux:   "3bf4bf6113f7f90a7d2fb5d25a1a9ba305aa1b0eebadd99c7972a77d936f1bfc"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
