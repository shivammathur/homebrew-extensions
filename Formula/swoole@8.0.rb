require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT80 < AbstractPhp80Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/master.tar.gz?v=swoole-4.5.2"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
