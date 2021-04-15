# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhp73Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.5.tar.gz"
  sha256 "c93f6a0623b90ca6a6c96f481e6a817f2930b4a582ca0388575b51aa4fb91d38"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "51f52e53187640e9795e020af7d8d356b5129ede8513a5deee9b17aff4867908"
    sha256 cellar: :any, big_sur:       "b6f4a2407cbebaa16797dcfef305877d4dbea4bc40bdf3b1c7bbe66db9ae280a"
    sha256 cellar: :any, catalina:      "069a108c8dff01e8003a746aea0d20167b55b6f7e81f67574f3f0242cc59e50b"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
