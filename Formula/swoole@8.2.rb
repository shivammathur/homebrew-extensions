# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "aa39dca220a5a49392597f17bee942e54af396cba7abb9b4a91e788c4e42c70d"
    sha256 cellar: :any,                 arm64_sequoia: "620514b7b1e67fcfb43106e732b2da1df10ecb39e95d201d4a6345daf5994308"
    sha256 cellar: :any,                 arm64_sonoma:  "cadd7a8accda63f357256392e1f231aa2bce387c29380fb56b45ab57b0b1247a"
    sha256 cellar: :any,                 sonoma:        "406f4824ce3f3a22b282b6fea7f654d4200e3a1b7ec827954d6327eb40f009ec"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ef0ebfdfd161f58228eaa54eb9c123e21cd26ad7a8e254728aa3dd6e7f20a023"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4ee9bb27e24a8c6f2bdfe93215769bb4268f10c616bff3ad876b411982bb4ac"
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
