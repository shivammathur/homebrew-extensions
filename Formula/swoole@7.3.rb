# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f3ba8fc20913e3b9394c6b161306cc882337b2378b0aee772f5f0b39e8f5c8b2"
    sha256 cellar: :any,                 big_sur:       "37e18a0f7086be789628db871a40ce9232f562dcccd86bef1405950e54967be8"
    sha256 cellar: :any,                 catalina:      "5b17974686c827a393a74bc06bb9783dc359b94ad8dda7a792435c5441d7f7cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e0102acd5da7c73dc162f00105dd84eb137e047eafcb7108025414b8969ce0bd"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
