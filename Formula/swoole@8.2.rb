# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.2.tar.gz"
  sha256 "b0bd47292add791b3bcebf347cd593c98a71c098dfeb96d125193bc95e95ed2f"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "be0eaed26a1b2c625326a8840b7a1cc8a34707584a754356e49dfa3d1b860906"
    sha256 cellar: :any,                 arm64_sonoma:  "85ebd0085528b536ef91aa6352e89b09b76e25b86d24e794d13c15f5e7b0e96c"
    sha256 cellar: :any,                 arm64_ventura: "773e6fbeb087b5a63e09856129309025befb9521209debad260423d6fc555208"
    sha256 cellar: :any,                 sonoma:        "a0c1e22585c9dd716525b48d1e8aa6eda00501c80581e65720e16ca44b0c08f7"
    sha256 cellar: :any,                 ventura:       "1405d88a3675d62bf93c84a68ff982ee1a7032133500b2e69d09233587c62b6a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b28a93c03fbc06f4c5f0b251e0ce2d094d63a3ac89ea1073fb0dcf2560b59dac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb10b6b622c80eec84ad130d588ef8a43c5a8f1c154e4a4740314e1d0d196ccc"
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
