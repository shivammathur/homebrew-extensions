# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5d754cbdf6650662aa97c340c6585417535bef7226793343f149f393f051789e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9ea21e47dae4e29ed90b5ebcb6e8b2aa21a3d80dd1b13e49295f866fc05ed3d4"
    sha256 cellar: :any_skip_relocation, ventura:        "34b98b6107174b6f2041702a33f98e025b9b9dc732f6053dea6ea3158083c864"
    sha256 cellar: :any_skip_relocation, monterey:       "fb6353ae8d0a28ab9dbe72412866928666acdb53ffdcb29f723bbbacf666dda6"
    sha256 cellar: :any_skip_relocation, big_sur:        "311d5b1503b5a96db56bf7e2669663cff8d4e48aa018dbcc69199391dfb57b90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d8f29934143cbe5e3c940b7b3274c49d74651e025da949e0fa9279d84ca11ad"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
