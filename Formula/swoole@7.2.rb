# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhp72Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.4.tar.gz"
  sha256 "fca3337a269db0533c0c7db10b48aeb9e6e5d7b84188d17ac59576b3f365fba3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "93af473d968a2ae4d0ec1e3958a7c5b3af1ab3be0470dfa5a43f2f18cbfbeb61"
    sha256 cellar: :any, big_sur:       "29b6fbbdc3ac6132eca0b7aba875f226bcd0eaf6eff33cd400f4022a505ff4d3"
    sha256 cellar: :any, catalina:      "cc170ae72e947200fda88cf03ff46d68ac5aeff763f3a911be16006c18db0864"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
