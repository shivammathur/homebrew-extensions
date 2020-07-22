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
    rebuild 15
    sha256 "ca2807a69fe3fa23711f29e8e172b3fc0ee4c7e03a49688ec35360794e95d8d7" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
