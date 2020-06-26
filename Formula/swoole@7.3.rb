require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT73 < AbstractPhp73Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.2.tar.gz"
  sha256 "35da484758f93ce0ce172d25a9606316e9042eb73916a427c7badad7ee71c977"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "bc0a621aeb801c6311a9d185ae45f0bfc6fcd6369ccb6cde909e510b9c9a9ccb" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
