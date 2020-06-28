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
    sha256 "4474790cad3d0f6f562c42715c3bf52194fcda5b2a710a885d4a8b4037420f9f" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
