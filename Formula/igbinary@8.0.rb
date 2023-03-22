# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0c5eb26a1466108e210b2095e90808fb17416287f304ecb6f8eb157cbb2dc468"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4e716b766d7b16fbd26dfaa3b9acfffb8c03dbb100b2e82696607442f1f2f90e"
    sha256 cellar: :any_skip_relocation, monterey:       "c20a21029ac8c72452406dfad74bb4096fb23933e6451f79c0972be2d81bf29b"
    sha256 cellar: :any_skip_relocation, big_sur:        "181558c079ba08fbe09bfd72f68823a7f7e80a574af505891d38f3b4974f5a08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "04b0d92d3356063d4426daaa4ce11edc2f6a184ec6c5cb78fd2e7332173f65e9"
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
