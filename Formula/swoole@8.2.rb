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
    sha256 cellar: :any,                 arm64_tahoe:   "cea33a2c4d1012719acf7890c2521ab86ed8f823c79b0eb4bece8a7a59c10148"
    sha256 cellar: :any,                 arm64_sequoia: "5a9c390898b446311eac4ef912b20ff993c7b366c61d4df35c917dcd365a66e0"
    sha256 cellar: :any,                 arm64_sonoma:  "0b66eceba8a67e05f34d91449107b797e8be8fefb1f29c0ba0a183bbd2384c0e"
    sha256 cellar: :any,                 sonoma:        "9d2fbb26264c175e7ac416965bc15c78a2244d90dd27b25dc8c8c95d01a48051"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ce0e645ca07b277383e72551c27cf1b801440fc4821d7bb101b786d7dbed0a3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e2ce46cff2a3bfe0f872b9282fa927a1f0e3bb2414d87d2aa0c9a27742eda95"
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
