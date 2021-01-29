# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.2.tar.gz"
  sha256 "9b1b53468d35dfb3aeabf07c81e6de3b9ab6a7b15f5f5f35af3cac41bd70762c"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 3
    sha256 big_sur: "4914a06238cf3955193f32dfa1c2dedab7e86c593cc264811018954440725a33"
    sha256 arm64_big_sur: "d6872d1d3ab9e73aa2d077eeb4cb4143a44d74e973818b1c5f919a8e264b6cf0"
    sha256 catalina: "fe3ff39189bca6bc8c2e9ef06a14213ff46b85661c880f0763d46f48f2f599fe"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
