require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class SwooleAT56 < AbstractPhp56Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v2.0.11.tar.gz"
  sha256 "d6a4e7541dad345aabd88811df9140b94393e7bc49769e53007dbba550766e31"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "b17afcdcfc51506f8fb536cbacaa932dba327c11f015f7fb5e45e2e89c8da158" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file
  end
end
