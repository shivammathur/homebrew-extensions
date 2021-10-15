# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "5f8aba852734f323d8a16ae6cb208a759a098f1f4b0d34007f91c18f82e8ade8"
    sha256 big_sur:       "cfea70d850ff7ec843befcb47f976de94d75e6b3fcd7da64611dbafe99255a39"
    sha256 catalina:      "06760ccd96c05f74046b239f3046210111e41168297307d81f15414e902b7eb2"
    sha256 x86_64_linux:  "a95752807641d708c6891960fd940655376901c430ad73e03bc4552ffc493555"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
