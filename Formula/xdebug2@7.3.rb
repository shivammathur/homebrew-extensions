# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class Xdebug2AT73 < AbstractPhp73Extension
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
    rebuild 1
    sha256 "9c9bcdf033eb9d821a53849f54117880899c867b4504514ee66e901da3fd5f8a" => :big_sur
    sha256 "800523c7227a1c6b915a5778198da29e109327a49443d165d56c287bcab0bacc" => :arm64_big_sur
    sha256 "a37b0fce364966b3a5b441148126b5b9102ff4e954a3dc7fa896548634615284" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
