# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT56 < AbstractPhp56Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "cf4e988a3805069c2fc0ff876cbda1ef84ea1474971a3b358122bf7109956b40" => :big_sur
    sha256 "41becc4471bec61058f9684636e5b7b5eca8e8b7ae7c2aa4d6427c69ac7b8985" => :arm64_big_sur
    sha256 "ddc7ec2f15a6615f8b1c07da9819e06419801d74c5b0a2be0f3b44ec1a08699f" => :catalina
  end

  def install
    Dir.chdir "xdebug-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
