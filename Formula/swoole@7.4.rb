# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.1.tar.gz"
  sha256 "7501aa0d6dc9ef197dbfa79bff070e751560a15107c976872ec363fee328b0f4"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ca38ed2a8c2a0e28d8e077e69a0be035fe5111829b19b2ee046c606fbcb804f8"
    sha256 cellar: :any,                 big_sur:       "564477366a8b4a9ff5a33546fa57d1cc7112b39c60bf802a2e87b4571aa68879"
    sha256 cellar: :any,                 catalina:      "47e5ec859abc81273a107a8c02ca55ce2cc0c8088bd53b2946e8d39ca1b0970d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46256da0493366b223d3d7608417b645f6762062dd938c2b3de33930b486f469"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
