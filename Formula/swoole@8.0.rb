# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.5.tar.gz"
  sha256 "c93f6a0623b90ca6a6c96f481e6a817f2930b4a582ca0388575b51aa4fb91d38"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "1cb0205de5bb83d9ada789eb949eac70625b2cd3b2de3e679c92d2723a2e1cab"
    sha256 cellar: :any, big_sur:       "f7fa5260af6929fe2b31cc7b3eca97168b9dfddcf70ee7f6b74a50b46043d34b"
    sha256 cellar: :any, catalina:      "66966b4eccf75e06308086bc06595c8e1ef1ff66827b2b38e6447fd948b80825"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
