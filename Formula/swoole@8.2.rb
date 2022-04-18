# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.9.tar.gz"
  sha256 "d859bd338959d4b0f56f1c5b3346b3dd96ff777df6a27c362b9da8a111b1f54d"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "6ddd024d199bb486fc3f08b0f3e837cb18df8600090dc773af380435453f4ca8"
    sha256 cellar: :any,                 big_sur:       "8620f5ef7790f7cd1f6913b57ec2d473013e70bbd2ac43870c4923f6874d321a"
    sha256 cellar: :any,                 catalina:      "2df08b2757bd42cefeb509be148e3d946342c5f679b2db060d740dc9485a5cdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47743faf6ea5403d91d4488223b744eea0d63e48060ce6975318159c2c2fe844"
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
