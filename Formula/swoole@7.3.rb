# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f6facc5c09ff2a80c3eaf7605871c4ffb0124c9f837642f11d2f9f8acda2221d"
    sha256 cellar: :any,                 big_sur:       "1c752ac142a2116e9071da8a1f21a4aa6bb1e0e66b65f6084c8a1fb72e90447a"
    sha256 cellar: :any,                 catalina:      "b4f0ebe22be9a6c775b51b2ea0bc6087680ba02f92b4da7617aed4486fefabb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3499a48b66ecd82597fe7c7e946c5e42ab2b94331fa1f63cb25dd9eef2fe638"
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
