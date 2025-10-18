# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT70 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.3.5.tar.gz"
  sha256 "fad1f7129e54ffae8fce34c75912953f3afdea40945e2b4bf925be163faf7cfc"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 ventura:      "7ff5e42f3a4838e1c7dd73fb86306f97c4aec6b6b746a80f39fa6e07f19f0ba0"
    sha256 cellar: :any,                 big_sur:      "855cfacc8597078e07e58197916d3e444fbdfe851d018c85795a058b66320e60"
    sha256 cellar: :any,                 catalina:     "4e0abf4220c24c5fb62fea6178a5a199709ed0d3b3509acb82d648c3763a6bcb"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8ad3a79e1928bc0b2482d21d35652bcdd597bc34ff1256993a7f1c3d142418a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc53684bdcbe20ba1ba7ebd0aa2961803977810c99b7b7dc9f8ac3a3ae8d36d6"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
