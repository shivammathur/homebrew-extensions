# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0.tar.gz"
  sha256 "fade992998cd89e088c46c80c0a853ef620d4a883de698a913b2dfe7f842d5bb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "11163daeb3432a17f4b7cb2fe0756bf6cb99f88863f1a62166b2483199bf80ea"
    sha256 cellar: :any,                 arm64_sonoma:  "6087ebca7f34ee2e2aeac746908f186ef42dc2d5322b4b14b46daac26a61434e"
    sha256 cellar: :any,                 arm64_ventura: "60cb84560eaa66c0c99f796b66eb15c632c78520f1d3bb49ed822792ecfece68"
    sha256 cellar: :any,                 ventura:       "c529221be14e77bb4c1ee92bad156d7a78bcb2fa664d6cbde7929fc89b8f2fe9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ff5fca4b7112cc46dffa06380dab4eedaa5aaa860a00cd2d379a0de5348864d"
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
