require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT80 < AbstractPhp80Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/master.tar.gz?v=swoole-4.5.2"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "395d5d1b43bf81a0671b2244de5927e6234197bd8b1a11bad6e93862e11ef249" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
