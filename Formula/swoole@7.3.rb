# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b8fbae31f5761cd4d9f0884e0bbd0aaf648ddab621ce49456d1ecc357c2c9776"
    sha256 cellar: :any,                 big_sur:       "57774f18c69b7e1c2a10098fbd32243bdf18fd987080e49b79d5457ffdfb2bd6"
    sha256 cellar: :any,                 catalina:      "bf8046d18c953f439ad1752a6b79f6f1d5820670ac71b3513fe05ce38ec55b96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4de23db5ce87fa7c236fd8370aff744927b1ffa582feb69b71689914a65ec6c9"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
