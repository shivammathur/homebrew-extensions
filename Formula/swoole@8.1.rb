# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3227d75cf58f4ae3bf95da487dabd140a661294f956c77c03ecaa363f8cd9209"
    sha256 cellar: :any,                 arm64_sequoia: "973ab0a952ea021a48455a4e773e5fdd89c7f882ea13adddc8237ba85230df2a"
    sha256 cellar: :any,                 arm64_sonoma:  "4904a22ae03f89c5aee2ff6db3fe7c8ccca06a914ab95ebb071cbcf757ed73d8"
    sha256 cellar: :any,                 sonoma:        "b56d1a3e20a35696cff6560e785b74886460895584118178b63b8867ec5ffbf2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e24d4e9e8882319ec53c7c98c73852b9bd32bb41854863e3812febd4d86d10ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4518e613988353f823986bd59d97107f4e8720421118d5a5ce098bcf4e2ee303"
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
