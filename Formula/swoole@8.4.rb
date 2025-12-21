# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.5.tar.gz"
  sha256 "36e6581c11f2bf277ac192d0521c719a6f234b91e5aceffe9e9eae9f3c39ac17"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "96bb259b1edd61b627ceb456fa5f16e3d012b3a7ed7626cb314d87f4b0c38bec"
    sha256 cellar: :any,                 arm64_sequoia: "db6c8abbca13d0bfc3ab5d700b00e8f0dac789e935c9c8c8b0fa3e9c9774d97c"
    sha256 cellar: :any,                 arm64_sonoma:  "ebbf3a3566cd7717a8dff7b7ed6d9bad91ca9d133ae58aecdccaddf697e949a5"
    sha256 cellar: :any,                 sonoma:        "d28b0b4fd0b6475ea6a93eb4630e11af93591b6e4a85028dde2f106da6fc7d50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e16aa564ac10922044b49044b1a8d3f6d249d97445663952bedf5dc4192c9989"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3857cd2d370272a504ea14e1e2ad712e3f3c67d59b709b2a41e7c74978f932cb"
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
