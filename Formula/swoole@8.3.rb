# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1c79701819095fd21cb59922d68c27491738f1f64eab147389d7195348c893cd"
    sha256 cellar: :any,                 arm64_ventura:  "0fe3dc5ae63f88adcd33701ed7d97965b8ae75c56fdad20d6fcfb7a53c72bd4f"
    sha256 cellar: :any,                 arm64_monterey: "e51804985fece511f947caa687d2ed3b8619de2cc3fdde9f526a8bba24676606"
    sha256 cellar: :any,                 ventura:        "da5d089cabc615da4969f86acbbe66968b846ed69ef3f2c6ff6f7d4eb13bd177"
    sha256 cellar: :any,                 monterey:       "69c648415b9cbf50c12955e9892716f13b84cb8e6abacf25179216b690df59e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38abedcafae45a6c27fac5fb1c337aceb1037a0e1e555db5480cef53414c926f"
  end

  depends_on "brotli"
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
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
