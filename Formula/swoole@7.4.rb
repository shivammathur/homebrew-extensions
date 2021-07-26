# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz"
  sha256 "a1d052079c370405f19bafb346e976a8b0e9a0a90c859af9cf752d4ef1025981"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "69fbd136e88eb2d031a028d4902030c08dc07ffc6dcf1a3d5656d61b4f43288b"
    sha256 cellar: :any,                 big_sur:       "b12f43eaedf4edada13052658378ab0cb83b412e816bc13a532fdc9378d65c98"
    sha256 cellar: :any,                 catalina:      "db412af25bcc7b71f06a2c684ab604bb3bf20e6ba5c6a5a1da0867f132e2e8c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e99f3f914870e3c41cebc44c0abb373ac75c6895129c6a6e4aed35df7274affb"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
