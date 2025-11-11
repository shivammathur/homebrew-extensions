# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "8c8b46d1fdd5bb3cd96a5b7b317fff8ca11933d121050ba2e5dd304a71a34e71"
    sha256 cellar: :any,                 arm64_sequoia: "c84a29e652f7852f25ee90bca3465f322180501ed2c5fcc0438a0ca98a5dfaa4"
    sha256 cellar: :any,                 arm64_sonoma:  "8e7313bae0448ceb627b08bcf8706678c43165b640d811ef60aebd3d45274367"
    sha256 cellar: :any,                 sonoma:        "2cd5648d316b3e3ef3fd6b244499976afa0f1de178d65f218a72e6c4a6ebfdab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9eaf8b29335250572d0c564141fdf548cef26fac9e4f55bbaf3e9a7f35b170c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31ec998094a352e5e03a06a370add828dc14ab53a68e559c3173ced6496e46b5"
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
