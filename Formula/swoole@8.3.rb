# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "2e84d672f686b65110d989f75ed45260418377e6544fd3daa1e3c634e75b6dcc"
    sha256 cellar: :any,                 arm64_monterey: "a874079770df6dc2604f81ca71ffbd95a2a11cb6caf5eb83ca7081b1077af169"
    sha256 cellar: :any,                 arm64_big_sur:  "5f81c9ab83aa28955b0aaf3e947b0a5edf912d52ac93f917841284b7f9881d02"
    sha256 cellar: :any,                 ventura:        "e9f9d49d0587f47b5a57d2f74f18ea53528285257bca7dcdbc5f3415bdcc42a7"
    sha256 cellar: :any,                 monterey:       "ea2d57986fb32f039fcc2c51666c1f7d0ce220a84daf955a86750363125b4836"
    sha256 cellar: :any,                 big_sur:        "bce400b46dc792dfe3f82d4ce1f3cbad707c3a9e738b1ff96c4b015c93d08d33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43e3c697ab103165c7d1769994ea382a3dd1933af6fedf38a427dab44df27f78"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
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
