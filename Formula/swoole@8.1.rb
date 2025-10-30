# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.1.tar.gz"
  sha256 "c2f0a5eece407e56ad73a3fbea2135a806cf40973b8a2a9e7aa844da8095c05e"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d4217576b4f3f4211ad27f47181188d832430c6d9f30240d2a3b5bf75a3536a8"
    sha256 cellar: :any,                 arm64_sequoia: "c898b03753e89b1370df79f956226ab212d4166edc9d489cc8691e2db0310595"
    sha256 cellar: :any,                 arm64_sonoma:  "e3791fcbcee045fc62b28dcb6ad4b669d3b393fe2370faefd6ee3f1f350b7438"
    sha256 cellar: :any,                 sonoma:        "4cfaf773713f9c1f337fb771b1c7684e6e9490684e369e24e790c79d974f26f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0165e94d49f513653d40ba3faaeffad7d2a8a372d79ed11b409bbc867e2d5b1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2144e37ae7e9cbd114aed911b1332a688ab2ebca4a0617ae2963a897a89696bc"
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
