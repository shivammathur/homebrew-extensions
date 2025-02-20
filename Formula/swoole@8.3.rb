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
    sha256 cellar: :any,                 arm64_sequoia: "b3758f1b38298ae71c20fac2cf07e06c505c5237fa587b5b873610dc6c11fe46"
    sha256 cellar: :any,                 arm64_sonoma:  "c98c05aa1b5d64e98c383bc10d8145b1da6f5453d5b053eb41ad0d4c9a992a71"
    sha256 cellar: :any,                 arm64_ventura: "f877ce53ff86ef0d68e9155884d894c5487fa7e027c16a79b8e17450e2870767"
    sha256 cellar: :any,                 ventura:       "af10edeb8bab466334134ee6c6743d00109184d6300b943eb58707f91478c942"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15500e39f7f39f96bedcbd40de6b8d6eb991b8d23080d05e27a8f811d465edce"
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
