# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "d6242c4a3c74e0cac8be6f8d5d1f7748b7f5c65b4ad59e405a8d831c3b8aabfa"
    sha256 cellar: :any,                 arm64_big_sur:  "dc65a3372f6562a7680574e374dd8316df70c216bb9bafaceea4dfa048c7af8c"
    sha256 cellar: :any,                 ventura:        "b9eb7c637bb62ac2dcf92456bc0f0eda104bbff6fc7004b2a985e572b5b926a7"
    sha256 cellar: :any,                 monterey:       "5551fb7cd5c6a25fc81f5d90e2ec379193a20c80da3b82e148b616df3c3d104b"
    sha256 cellar: :any,                 big_sur:        "6100d9f4f8a497887ee0cecaf4d4a1b23e50b72ce80149c81f0a4ba60fae2b34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1110d87501cf512af5acc0c67518eed7bd72826e7071922963144e360978c5da"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
