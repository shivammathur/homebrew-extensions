# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8c35c0ca85c14227991b1b290b45d6c2a46463a549bf9d1d46f0bc859c16331e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8a11c71ebec1a6408af44af8aac746d2bb5b53f4480bd0e1bc349b044563386f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2c1e9edca158df7f6931b4a290dbbdf8565613f543eb066ebcdcd96f2c214d6"
    sha256 cellar: :any_skip_relocation, ventura:        "0a8c5dbf097ccfe890748b3924670bb8c2cecb393618cb50e101be625463d4b0"
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
