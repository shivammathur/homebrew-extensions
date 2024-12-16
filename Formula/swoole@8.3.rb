# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0.tar.gz"
  sha256 "fade992998cd89e088c46c80c0a853ef620d4a883de698a913b2dfe7f842d5bb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "49ffd2c10bc03f1a14aa1dc44cf212b4929dffe3ee72bf428a1d18f2e7ffc43f"
    sha256 cellar: :any,                 arm64_sonoma:  "d21fcd5ae00d92cba569c0b4e765a02f284ae1c84a57dc811ac6d17731c78ee9"
    sha256 cellar: :any,                 arm64_ventura: "d1caa94eea36f9936e1557042ebfc9a01bf43e0b1dd73da7fbd5f9f807ad62cb"
    sha256 cellar: :any,                 ventura:       "ea04d99e82768968c518637c175ebd6ae4931f9a181e7e221d42ff311fa3acef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "392858a1dafe68de9b723a93a9d9d3cddefe44b6bbaa5ec6e4340f9b5a1bf219"
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
