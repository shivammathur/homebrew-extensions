# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b7afce1e79ab35308735f88cea10a1c2abb6656a84d442198d39d0bf865a17a4"
    sha256 cellar: :any_skip_relocation, big_sur:       "756df77be5b2079177d9341c7bc6e1494cda45d7e9d562c10d6198c0f88bb93d"
    sha256 cellar: :any_skip_relocation, catalina:      "6e882fab6484a9217e9fa6593f3474debf90fa973c47bcf3c07ec1a0d8bda34f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d85e0b8668f525c5064cb62e0d7b28546b6bf68ab00e79d8e2c42f2c1e0a99ac"
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
