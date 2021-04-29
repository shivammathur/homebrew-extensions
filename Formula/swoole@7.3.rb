# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.6.tar.gz"
  sha256 "8cd397bda05da1f3a546a6c537b8896e668af1ae96af8b6c4b2bbf8af57c7dee"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "a677bd6e54915f797b74fd92d5ec397520e3eaca87738331220c63567ecf43eb"
    sha256 cellar: :any, big_sur:       "e947d93fe007622e17e321a140f6dfe013368088a814ef797edeb09302081ab2"
    sha256 cellar: :any, catalina:      "0dd3a929e3be2344daa54377230b17f59d43c37f7561142842fe0ddb24b7fb0f"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
