# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a042e73c3820cd8945497ea43a9219edd771e68a083136ed7d2da50d1412e03b"
    sha256 cellar: :any,                 big_sur:       "01ee3642d4b3afe62d0b4d993122d4effe80a7875f959aa99743fdd4bc8582fb"
    sha256 cellar: :any,                 catalina:      "4da7757de802707ac3e035359d2b14aeb16847f79787ddcdf134303710ea7b44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79e3c38a8bb2860a6df3cbc0aba59b11b2934e13f751ed353f90c1c91b793d3b"
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
