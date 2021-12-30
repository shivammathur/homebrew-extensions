# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a0ce493e71b6c462ec9cda87f72e34c671c481bb35bf47e6bbf5f8ab659216f2"
    sha256 cellar: :any,                 big_sur:       "67f854eeb836485aa73689c40ed42e9779daca80759b63b1ff014c244933ada9"
    sha256 cellar: :any,                 catalina:      "b914faaf66ef4bf81cab02611b31db6801406565b7bfde84a7a91c7752679e44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa10ae982f570d334e3b840f5f3a4d8049758ed9f7621dea84065e4052875814"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
