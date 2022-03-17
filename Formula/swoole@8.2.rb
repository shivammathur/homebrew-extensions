# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5026772c2a674a6d0c8f7c39ddae786fd2e39b5c4341c30f347e767ba6237179"
    sha256 cellar: :any,                 big_sur:       "e30cead38bf8fb8c57f7a998ae728487311dda2b7dbbca0dd53110f80132ba98"
    sha256 cellar: :any,                 catalina:      "ac2d2f11b7cff777e9a508f593e91c4ba62382dc8493935e995c916aa05f943d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bbd20c34ac5138779ff874d6a5e238e0a4e87011309185f98332b939ecb01c4"
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
