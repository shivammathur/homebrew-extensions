# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "8f77b19a4d5cb37eb969aa27a152c265338010a1932ded222f5eee6c263b41b6"
    sha256 big_sur:       "c9d023e366550054318d82f58c7912c21e13c8d8070197d63b46b0b742307792"
    sha256 catalina:      "c687f0c9d8425659b35cd720c29f8ce63b363e24e374f79d96efaac3818d2f8a"
    sha256 x86_64_linux:  "e56de438a5fff4c33f91544b003ca05e4fb4e681b52948bae0024cf6fda715c8"
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
