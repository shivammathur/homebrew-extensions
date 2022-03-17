# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "9b5958f142341f36a91c9a0b1363f612385cde98707aa1c91333edf160c5bbd3"
    sha256 cellar: :any,                 big_sur:       "79747f922d73c14c4864ee743f804b33b4c0a471d62554a11bcda38e9167a07c"
    sha256 cellar: :any,                 catalina:      "597b6689d9ddf4284f551b5517ac7bdf2e6a1c18d8e0a26719466f50138d2bef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00b1f9f73c45e58f872494ba274d962a2513ec0812a98d47ed4119449c43b8fc"
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
