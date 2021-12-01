# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "12b50caffbc785ec3df433cd606cc6aa6297f2ecdcc78753d40545d181530b65"
    sha256 cellar: :any,                 big_sur:       "4bc303767d1569ab99287dae6d10735351c134650a8e241aa4ea1ddf97ca2e45"
    sha256 cellar: :any,                 catalina:      "eba58dc1cab1b116ecf48a8cfb64018d99f344a5f64bd9aee90bc2905ad252c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fbf1e44f9c3d142b5381f20850fac949335d079a65313ce10d7d26be51288985"
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
