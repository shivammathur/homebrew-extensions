# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "0c55965df139865b6c87e20e24b51eabd831985c3388405d955f13e6d112a848"
    sha256 cellar: :any,                 arm64_sequoia: "063230ec4dd71400c33f71181c32d084706ff581ec3fac69085bba09c37b6abd"
    sha256 cellar: :any,                 arm64_sonoma:  "a0a3a450ba52757ebafc2c6028115c54635cd0454f7ab29425ccf4eaa35bd17d"
    sha256 cellar: :any,                 sonoma:        "ca80824b5159731a455867e1c4c7da5584af2404c122e47c65d19a40f3427446"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "12a7ea2d294d65d7c73ee4d4328124910495dc4249bb98db1a05b3385757023c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ada905abd9269ec21df432addec6c4302f122c7d5c41bca216bc8ef78ea64d0"
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
