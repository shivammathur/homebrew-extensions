# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "34489506c1748598c461f4bbf19b109b0e6ebff632c7ea49395d3ef2a0f37427"
    sha256 cellar: :any,                 arm64_big_sur:  "d0a5d410c8cb7ba50f7afce72e04985876988710dc9bb431684ea1a805006578"
    sha256 cellar: :any,                 ventura:        "5e90cbacdff3e34009d1e21e2bb8f480f91d1b9043d4c36c750c8993b08b2af0"
    sha256 cellar: :any,                 monterey:       "b309e1a5d043e2d9b9606a3d27405144d8c9d3d57167172821f159c683bbd991"
    sha256 cellar: :any,                 big_sur:        "b819e3c260dc30c31193095a45cec00903114c3c2ff01a4aaaf9c0bd66442532"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a23676b2e2f05e8a5d5e58a90480b3964861954a1c8f6b6ed1f12aa3e7a714c2"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
