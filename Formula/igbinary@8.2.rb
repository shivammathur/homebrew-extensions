# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1c1aa30e3ae9cb5daca88ef7254b99e8f87425bc2f3fb3062fa92d02a0e8ba2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "14977a06a5ab885df83406b7186ccc229bca056205f14d68243205a551f4cdc5"
    sha256 cellar: :any_skip_relocation, monterey:       "f3f2bc42dbc46bb881cbcf50787ffc24d22fc834f40cee516c7dab6d6236fa74"
    sha256 cellar: :any_skip_relocation, big_sur:        "8b747288d6dec5e2aa4465df53567d05b71f858c01d146883528de2ca91420b2"
    sha256 cellar: :any_skip_relocation, catalina:       "11d4897d35307fe684c3d599ec3c8e255a211263ab62fe661a841b8ea4f1bba5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49177bef798de98393950d19df17cb5cec32689b70f8031ab13cb885e7cbdb1b"
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
