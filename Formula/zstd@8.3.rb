# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.16.0.tgz"
  sha256 "3d5bfdd1c70b0e3e892461fca3bc74e899322c69404b706fec27af8118d9bf99"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "2b095df6fdc5021eacca78dfbf149ddcf6b15e60d7ae9355647d7a1fb9aadaf2"
    sha256 cellar: :any, arm64_sequoia: "ef3dd94a55e97309cf50dcf3c2fca22602ca1a849ed3d2007dd2566066144f92"
    sha256 cellar: :any, arm64_sonoma:  "a662b2bab3787422c7ce7d210b5040d49267e291ce9343944a7b48da79c02c31"
    sha256 cellar: :any, sonoma:        "edfa7c427d29022c93ba2d774a5ecea40ad54fc7852da289e4dd21d226e7ba48"
    sha256 cellar: :any, arm64_linux:   "74a4385515e377229098988e2a6fc88ebee3355035d15ee6541c68623c07dd95"
    sha256 cellar: :any, x86_64_linux:  "93c8ae99305649c2380d17fd9d997fef443d509aea51f8843be65ce6d9dcea09"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
