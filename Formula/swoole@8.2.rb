# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.6.tar.gz"
  sha256 "0234d336dd19f56b7e175dddd7ce61b17b00ba24426072018d781c9815c263ac"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "53679a03a60150a8ce9c19422c6025a5a8c348cb62ecbcf52695305ccb2721ef"
    sha256 cellar: :any,                 big_sur:       "98cb51fbfab1c22f88f7bb9e8e9f2540d54476b0fb75b45d1ca8d76f99c4c4de"
    sha256 cellar: :any,                 catalina:      "63d7944f1615a0f0011b9923de77d6eb1ef53aeb440f4e9476beb7be7bb7aa7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7683a43e0e8c5a0463523463f9c61588b3843c4aee6d14007203461fd91c8de0"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
