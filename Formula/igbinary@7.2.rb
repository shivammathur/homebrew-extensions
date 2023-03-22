# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8a11c71ebec1a6408af44af8aac746d2bb5b53f4480bd0e1bc349b044563386f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2c1e9edca158df7f6931b4a290dbbdf8565613f543eb066ebcdcd96f2c214d6"
    sha256 cellar: :any_skip_relocation, monterey:       "d0d10d9b96bbd87aa012e7e925b0ebdc6f314f973840f49afba340f932dcc6c1"
    sha256 cellar: :any_skip_relocation, big_sur:        "af25db29353c43b9dc61a3463fd08dc7521be2cb64fef0a43f719801135e381f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4151169a77f2951fd122b0cf0bfe5cc8acc941c47c6628011f314f3d569024a0"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
