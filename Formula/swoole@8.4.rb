# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "89423cb59cb87333d8924f0b12217e145fc3643c81cca31f874024ca09042f7e"
    sha256 cellar: :any,                 arm64_sequoia: "803d28360108808c4bcf1993fd10c2c50c702a1a4031d0bfb6c3a3b69851fd4e"
    sha256 cellar: :any,                 arm64_sonoma:  "cd6a44afe9064bb2accf2aa1c88ee5b1b1051aebf72df105d8334b25857be0d6"
    sha256 cellar: :any,                 sonoma:        "bcd5de1807c97c37342677d74ccd9fbf61864db068110144e85e984c3cf47603"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "01513da3fc8e31d2294d77b6073b3c6a6ca58dd51179e033f3cba0dac292e64f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5d3a00f645f9a8947dc5a54aa37fd019fdd04bf3d194d4b3c720aef69d70fe3"
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
