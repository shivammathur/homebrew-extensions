# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.12.0.tgz"
  sha256 "a9ebb880b2a558d3d6684f6e6802c53c5bffa49e1ee60d1473a7124fc9cb72ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "7709d2301b2e4c64d02b563af20f15e0ac95bb8adbfe80d2f1f10d0b751cb026"
    sha256 cellar: :any,                 arm64_monterey: "f7c6568c043bb6ff9e01eb1c06e0bd70ef2608f603f8e9a552b0cca4b878019b"
    sha256 cellar: :any,                 arm64_big_sur:  "2684c90bc7e040134a593c2608587c2e93307fa9eab96e15405120f996e7e6dd"
    sha256 cellar: :any,                 ventura:        "a006cd4850641224f83cd318856b337a423123d8098b1d7b8ccf51f8c82c4f91"
    sha256 cellar: :any,                 monterey:       "3829124f270b8d81c2bdbe5b06d50b1c900132e730d39ea202aa099a11e774b5"
    sha256 cellar: :any,                 big_sur:        "4be787ffa668173c1792b5a6449416204f0769cbbb9abde3872d10ff239edeb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fca74e616ee247bb6efd1d0b1e4d9afc8c37120618c3373066424b54a205cf8e"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
