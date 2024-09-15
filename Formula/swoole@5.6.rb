# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT56 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v2.0.10-stable.tar.gz"
  sha256 "ea1c8cfdef0e43f2b34460f88f4aaa5c1ca5408126008d332ae4316e1c9549ff"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "86cd87dee2eab602e0125ca51b1090b9e498a6a0b8b20a483a8e34524b768e6d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7efac42ccecb2c7a79051c93adb0a82bf2479ca58752cb0d0ec8556811c099b1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "65a35ecbfeac7085c57e2648a6a532678f8a5c628f0dcfa189d81fbb95b5f2b5"
    sha256 cellar: :any,                 arm64_big_sur:  "f28428b883330b4244a7f89185afdcd7f08b5409e95441ee8c11438c3b2ea823"
    sha256 cellar: :any_skip_relocation, ventura:        "1bfe4ff7f78159cffc6c4c605807817cc4f07d85f5550b7802da08398f938cd6"
    sha256 cellar: :any,                 big_sur:        "d362d6909b98f39ec895c6674187f4b87b47a221655f842237b9c6d89b1b4650"
    sha256 cellar: :any,                 catalina:       "ccbb598f8294da5e874c080bbbfbee8c470ef3dd12c7d4c599ccc94c0290c243"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ed628f339319b4cd58eec7654358fc0206fa6550b6bdc6450e75dc6b46f51430"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
