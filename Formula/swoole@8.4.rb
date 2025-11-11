# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a19ee88fb37d9973c4c55d1d1df63715f7f2e28dfb11f8461fdfb06a132d7ec3"
    sha256 cellar: :any,                 arm64_sequoia: "758cc1fa7dabbcd5791ddd4807139d8f80f9c59ece9171db971fe94053d07d86"
    sha256 cellar: :any,                 arm64_sonoma:  "91d7b27d8023be399a73cbfe7fc697f82bc76fd050deb960d2558dd7110a19cb"
    sha256 cellar: :any,                 sonoma:        "c4af6d75c68b58125d192dffaf997bc34d1d19965e3408a0e79821fff876fe54"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1170a22fb89f65e37f29241d04d637259813de6f48d5807d64b80453966a4e97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f8f14e8345881c2045c1508af588d49e0fb1a92ffd1cdbd885b5010cdbe940e"
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
