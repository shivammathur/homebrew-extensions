# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.4.tar.gz"
  sha256 "96e7e5c72062c797c25d547418c7bf4795515302845682b7a8aa61596e797494"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1bcc246f27b917145a3308d33167926940877bd00c8e3cffe88f5d68d75a1b03"
    sha256 cellar: :any,                 arm64_sequoia: "9d45e16923833f49aed6b61f6c92137e4658e1410ea4e79eea087580d5763357"
    sha256 cellar: :any,                 arm64_sonoma:  "aa513e3454ebb6550e2da515789f0c49ed343220c19dfed086ba9a61237ceaeb"
    sha256 cellar: :any,                 sonoma:        "aa4897b45796e40db2968b06027eaac8a702514e3da1af14b20c47c5becc7779"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa27e4c35587367a52be2fd0ff81ce856cf84b4818795a695cf25b1ec78b5712"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "07c18f9a0daf5a405c82fc351feec27e01905ebf3984e46d888dac42aef8aea7"
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
