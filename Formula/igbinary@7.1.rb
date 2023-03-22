# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e90fda06c1db3e36fb0f341d6bbb2aa551815e01ba111419e0679633ad8d7919"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aab4ef9fdf873c2d7dbb1e4437b91423b959ac1ea6fa128772d75796b012b4b0"
    sha256 cellar: :any_skip_relocation, monterey:       "76672f53a9f0b47ede5cc7a700516dc83f1c9decffd5706f59ae79515505c51c"
    sha256 cellar: :any_skip_relocation, big_sur:        "6ad7022e149b4475791302596c45636ca4dac53756fac320c5520fe26e8b32f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a76b4735936bd083eb8ac6647f6629f2a1bab1d6e61215096555ed088777f95d"
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
