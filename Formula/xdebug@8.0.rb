# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "7529c379d368343fc4f66ac641b075a8a3605ed530dbb779321fd3e81b576673"
    sha256 big_sur:       "3ff6144fcfe8f549876eb1c1dc0e69506aafc07a69abf3adba9a106d5e6e6b8b"
    sha256 catalina:      "ec58f4fdd0d86cdd492de7b1af4f16a2c15077f53e20b1f0e76e41685c5a8908"
    sha256 x86_64_linux:  "5f9d97a622e70d8e3f122fbb02165990d321110faad460238293994e6b59eda3"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
