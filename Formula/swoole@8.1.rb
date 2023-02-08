# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "cbfce27ccb981de174dc30aaa5c885654ed54c61990dcca6312e3d848e08f496"
    sha256 cellar: :any,                 arm64_big_sur:  "b5ac86371149f0ee72c337a100732ca94727ce069a17c0d0372cec5713454d8b"
    sha256 cellar: :any,                 monterey:       "9874037869a974db074436411db488babbbd831d159804822732293c516570ee"
    sha256 cellar: :any,                 big_sur:        "5044cb99c5027f41ac536b9c93fccfa72e94e107f38602480b5fcc144160bc0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ab1d3f83be3b0ad17a8fa6e1302ca384465740c3df7cf957278f572351729bc"
  end

  depends_on "brotli"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
