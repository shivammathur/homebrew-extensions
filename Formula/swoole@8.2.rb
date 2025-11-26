# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.3.tar.gz"
  sha256 "8f1ca615314f7dc0d516fd95d68484b62b330de61861fa50282617b4e62a22f5"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ab1bf506f957efabbabc72d88b8e98db52bd1c4eb80dadbc698ed7cb4325b51c"
    sha256 cellar: :any,                 arm64_sequoia: "aa70551d101c97e7e2302cc6f53d038be5865d206b8d6e88e308d4a37424ee2e"
    sha256 cellar: :any,                 arm64_sonoma:  "c54ddf8726753890234f22e3b02483ad991508b95ee83fa5e4e5d7a6185de8f2"
    sha256 cellar: :any,                 sonoma:        "99714f0789a32a1d3c07395482ecb3414fe8f702e4eabc7599f6bce41386ffe0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1b7f92a922d716a7afd66360d2bcb268eed77f970d6d60afb1005466b60f5349"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5b51784b8cb1bfa538c32994b9dacad46dd402628c850bdf494bab15413436f"
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
