# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a8486cae75546ab2059d40c76366bc1e89a51937f084e9214e7d4106e2c57666"
    sha256 cellar: :any,                 arm64_sequoia: "f9dfdbfac2d3594455d904156c62acb5340a97b6965f9b6145a1b456a5dd09b7"
    sha256 cellar: :any,                 arm64_sonoma:  "2a6cb4486e6360b6f094696ced5c54d5c0a0a410d85ed2dd95a8b5f020ecde89"
    sha256 cellar: :any,                 sonoma:        "5af24d9e2b641d3e426b7b1ab4f15e8a9df03a532f54bd20934dbf6e9845d867"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f045a797209d0d4b3382e24517f58cf75900be353f772a0ba205fb5ef50146f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "abdffc90ce3235ba5f03829dd55c9844c456a44eb16c3b41df9016ed2f1aab1f"
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
