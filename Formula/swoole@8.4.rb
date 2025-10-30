# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "44d9110e88d267c060a5b4f53696c50600a332a1245f3c876bed0c1d061343fa"
    sha256 cellar: :any,                 arm64_sequoia: "760372537c5986e7c1e72f0de5be68799ed56688b2f680867a4f77e283a03d84"
    sha256 cellar: :any,                 arm64_sonoma:  "0e8d70afc4707a8048315c6db3573e1f359950df5eb0f3af1981448ae734f734"
    sha256 cellar: :any,                 sonoma:        "ff0da512dd6ffa5f10ba159cf95a9f3f2884d3b669f097aa017ebc8e11057235"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fbb1018c1743f55823729aead228dd7ef3bf7fc9f6e1f58f49e8fae16824167"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "929688da1015234fa527fea7e7a405fe2417ab9cbd4d3253ae3f2d7cf6a8c25c"
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
