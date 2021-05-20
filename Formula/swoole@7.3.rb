# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.7.tar.gz"
  sha256 "f64bf733e03c2803ac4f08ff292963a2ec1b91b6ab029a24c1f9894b6c8aa28e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "99051ca5c51708c40b3954856c3fef62e215c26b25d06c9786ad22e78d895e85"
    sha256 cellar: :any, big_sur:       "817f71ee1da386948b4162a8dba85d57df91fd5565223bdbab74448cb54ef444"
    sha256 cellar: :any, catalina:      "eac7dd1c6b5cba29527f671d7340aaf5e63938a14514696a82828f4e0fd69a16"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
