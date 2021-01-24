# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class Xdebug2AT72 < AbstractPhp72Extension
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
    sha256 "849db23fc149074d58772947adce827f8eb04b95e42dc8a16c109fa8b6f5f8f2" => :big_sur
    sha256 "884c4d7ecff7a25a153b564acfd8ab56cd23d84ff6638ca2330157a39ea84992" => :arm64_big_sur
    sha256 "be532f6cf3d6037d28a6cc03154fc673920f1df41d559eb19ab69c67fe05dece" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
