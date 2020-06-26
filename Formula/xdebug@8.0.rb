require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XdebugAT80 < AbstractPhp80Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/master.tar.gz?v=xdebug-3.0.0"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "bda3ac13cb0ad6321800493e3cf27fcc9160ad9944cbbec8a94550c69c567d3d" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
