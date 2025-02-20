# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.1.tar.gz"
  sha256 "c1e35bbb4714e44d3c180a292ae2b55cf94de8d8f2a3b197d1e844f866a0e5fb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fdc30ab898f9a6429aa95cc8061e1760ce17d9f1439c53b91910c5207feeae4f"
    sha256 cellar: :any,                 arm64_sonoma:  "0a525b10251b3681a5fe7ba29ce9ec2a1804b41fcb6a0d643da9c59aef62e26c"
    sha256 cellar: :any,                 arm64_ventura: "75ebf79780ade9853b3c94db52325887af371235135ce2d09342fd0e208c8d24"
    sha256 cellar: :any,                 ventura:       "d68b2ebd9637ec792ffe638e6fb96200cbde1c751752e0eb41c2ea3d0b09ecd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1a1d50fd78febb55ecfb3d49934659f08a221144e0390097ce325c6e3440814"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
