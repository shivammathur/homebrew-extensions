# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.12.tar.gz"
  sha256 "ac0f5b3cb9ef2e04f0325fd4d2048bc727d545c56ae9d7525c9150b33ae55b7c"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "1b009af5b40cb0509228698f8282cbc37eb85294fbffe56f91b70fd889b15cf5"
    sha256 cellar: :any,                 arm64_big_sur:  "9c88d79075005443b411dad994540c9c01b95b9ea8c9fa257f9ebed739702fbb"
    sha256 cellar: :any,                 monterey:       "4a689ed08943244dc1cef983499434b532697e2321abf6124769a4b6cd06e40e"
    sha256 cellar: :any,                 big_sur:        "a28fad08fec4fc3512c674788388199c670362c52f0e1ddde191db869c125cc5"
    sha256 cellar: :any,                 catalina:       "813f7438c0f600371a51b3e137d91443367d2379246d151f4e5bc15c3fc34679"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c91d343925d24331cf0d71ded15e33f4fb137953ea6c6c1ebfda8b3fe313b3d"
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
