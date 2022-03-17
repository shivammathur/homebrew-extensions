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
    sha256 cellar: :any,                 arm64_big_sur: "7379ca928637c997a6e268f9876eb6d11a6f5e6d8ca0943ed30389b12a558d62"
    sha256 cellar: :any,                 big_sur:       "efcd05bf12910e3e13e5043f5c4b2e7929be6de3c803069ce55ae9043304c7ce"
    sha256 cellar: :any,                 catalina:      "d60b2f4eb2dce3a109eeb8b3f6c1bd12169bdb7468cb4774da6455284a4635df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee930ecb10eb645ab91a84f502276c247b865898440e413757f61b4734d0d6f2"
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
