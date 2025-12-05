# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/e551baf4de1f3ea8aedcb65d43bef8252693e176.tar.gz"
  sha256 "371c9c5d0fdfb7085be3ab99c81675c87cfa7b10b5011f2b2a6e6e63111ce1b0"
  version "6.1.3"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "db9165655f012286e0dbebd2262a928f2c190e183cf03e548fe62abff5794820"
    sha256 cellar: :any,                 arm64_sequoia: "577df20e1789f24d21b707fa3c703300868d25dce373a8822cd83f5e46c504f3"
    sha256 cellar: :any,                 arm64_sonoma:  "46eed004e002ff8481e61cc4b8d18752b8df09fa3cb54545a9904090428420ae"
    sha256 cellar: :any,                 sonoma:        "73a8737ab62441f245171c722bf1908c92d74fd52cbcd08dcdd5189bf2ee2389"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4eeef689ed96c0b50f751b717e623333e3a2074be3e18d7ca90c50fa724faccb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54afb43c143b71b4932ffc38c55ed118d766ccdd573b69b372c793ff16614158"
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
