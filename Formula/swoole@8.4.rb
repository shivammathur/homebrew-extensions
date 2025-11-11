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
    sha256 cellar: :any,                 arm64_tahoe:   "17fda172890976c7f649675e6895dae489884c49dd311afa95568cd514aa1a35"
    sha256 cellar: :any,                 arm64_sequoia: "8e874d4a348965de6d0e7f843e7ab7869ca675afefc2b49995fb44b14e090bf2"
    sha256 cellar: :any,                 arm64_sonoma:  "4ac8c7f96a09c2bcbaddcbd5f16fca6a013b889ce063839fb3114dfefe60705a"
    sha256 cellar: :any,                 sonoma:        "b73060eb889e4ad207fec21dff824a477790e0f52a5e3f9426e612391cc33f94"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ba7dd9f9495331175a91864152eb1182ba389d818088d618a6830df4e6cbc9a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdd4a658326329dfbeaf1a356e85b5f22fb3b7e1b939914a69f21854998c7b5b"
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
