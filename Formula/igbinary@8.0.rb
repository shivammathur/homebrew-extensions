# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/igbinary@8.0-3.2.12"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "462065d82828fa871f156751224fe3d8f23635dd1b8bfb59fbc1705e00e56968"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ca3e3e685c0a2c13ccc5a962685b1af50dc46af7a8f6ce19bfe3a1d976500edb"
    sha256 cellar: :any_skip_relocation, monterey:       "4b8da8e46bdf126a3713b382d7170f3addb83cb4c388f3e4492ee45f5e98689d"
    sha256 cellar: :any_skip_relocation, big_sur:        "e22dd021bb0650c2fce0a612ce6b0c959e03f4531da85300f5d9966852719151"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb0e972d8181c520b2e44e91dd5e6900e1f91104134b62754a3fa6ea32d5bb2a"
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
