# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.2.tar.gz"
  sha256 "240d9ab8afbd18fc50f7f5f3b98127a9620f80179998e9337423e554e4d59a65"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "45781f9ccbe7d616ca090b3d03a10b49bea0b3e8305c5b97244fa2151b826edf"
    sha256 cellar: :any,                 arm64_sequoia: "294bc929bea89a2ecd70c9b6a71c5b710aff4a18043ea54600f3aafe2f6d04db"
    sha256 cellar: :any,                 arm64_sonoma:  "dbe57a08e2ff9fc31a2c5f826753004866bca781a8fbdff0c7d38ac5f4fa2f64"
    sha256 cellar: :any,                 sonoma:        "6332fca7c259e6df574630a6af0b5589306c76a5c32e2c06220fc7a537f0d5fc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c6cd007db3a34ebcca9b200e13f2e70ab0de38073d35fae536d778691dee634"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01248ea4518883bf54b2a7dfc1f218526a1088ba217ffb2dbb43006b608204de"
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
