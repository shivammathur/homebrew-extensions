# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "b0f6ac46ef0a28c82736d4e9c24f39d33221c9d1b85956e802fcb08e23e1e95b"
    sha256 cellar: :any,                 arm64_sequoia: "abe01818db54eae82a676c148dbdc0134c774680245decd8bc8884bfed282639"
    sha256 cellar: :any,                 arm64_sonoma:  "a6c6ecd8ce945fc2d8274eb0aa2ccaaea06e23f32d2a59e8736c5f110d9af9e0"
    sha256 cellar: :any,                 sonoma:        "a2233d786a2b17a65415d3ede9edd5108792aff29938353917e19c6d3623720e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "42e22daf418e758d1b70fc11026e613d2d4ccdaec06185a3816fc055f870f05f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "493c2f7dda333c792adaa3d7e0abef82319a314efd67619625a44bfcfde27ed1"
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
