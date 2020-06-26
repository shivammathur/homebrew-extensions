require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT71 < AbstractPhp71Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.2.tar.gz"
  sha256 "35da484758f93ce0ce172d25a9606316e9042eb73916a427c7badad7ee71c977"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "adb1b87ab87105d90969be4164c925afb72ce0c0924faba82dd51b1fc9816f38" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
