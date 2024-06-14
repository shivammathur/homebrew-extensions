# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.3.tar.gz"
  sha256 "dc7a24094fe86025de4a0fed2a94005d2266a29332e7e9e6be50238a8ef6cafb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4b98441ab427526974630af5f484c92a481e982f80437435e34afe7e28c42889"
    sha256 cellar: :any,                 arm64_ventura:  "dd3b0f818e5ce197e6a086ab8492c9882cf467e9f425cbb4f6eb75290aad0ee3"
    sha256 cellar: :any,                 arm64_monterey: "474baa10e1aeb5ae1be6365086eee10948314714ffc35668a7331ec7bc28350e"
    sha256 cellar: :any,                 ventura:        "a863793aae8ad2445b3f0cfea657d424db5efd73f86ac9b8877bcad6100a793c"
    sha256 cellar: :any,                 monterey:       "29bd579cf1ef4265a34730f63a445485d90275e8beffe5b7618eeb1195edea80"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "971e05a3aa3efa13cce16a8db7c50087db833d98b54d668addbc9a1ac7053e58"
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
