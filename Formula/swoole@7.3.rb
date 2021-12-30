# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5831daf2042f0581e82bffe3967907a8f6f5f9a896d6c1486bf5d2c7967079a1"
    sha256 cellar: :any,                 big_sur:       "99d9e6c715590e21920f1926b1a406c321aacbe38e19babdcb8ce87533d1fcaa"
    sha256 cellar: :any,                 catalina:      "18353b95f469f0c6f0e7230cf8ab137a2882bc442cec336d2148f2ce01dfe1cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9755bdda8ae15464f9d507772c59bedf5503a93d766f475d2ec7a83ce232ef4"
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
