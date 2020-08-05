require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT72 < AbstractPhp72Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.2.tar.gz"
  sha256 "35da484758f93ce0ce172d25a9606316e9042eb73916a427c7badad7ee71c977"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache License 2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "95d2811541bbb26666850ad139ff0188615acc81bce0116a8546717102cf8779" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
