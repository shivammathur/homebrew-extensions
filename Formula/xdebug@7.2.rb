# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhp72Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "40c69d44e827f48b38261dd53d3baeef6297a32f0014587e93e5e4452302424e" => :big_sur
    sha256 "83c970c210e5b85a743e81485c87527c950b502fe73ec3fc00a2878a2489999e" => :arm64_big_sur
    sha256 "374d9c6edccef56d901b64c7f27baea4757307da7eaa96b566dfc6627e8fdb9c" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
