# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6f0bdd173c86388412cf7898b0d77559985046c5f74b14545023e1fa764a7ea8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9230b43285acba37a72cb77f49c424ebb61e422b32edcd03690cc2cf85434bf9"
    sha256 cellar: :any_skip_relocation, monterey:       "559ee1cfbf7a230b764b14e827706717227646b8188704c7c2a8ea92098b7b10"
    sha256 cellar: :any_skip_relocation, big_sur:        "9f2c9f1049b2b245018aac161b23f6629c57a5f6ad53763862317caa01f27efd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3dcd4a3cc6084c0a0d8337deb6924c8b755cf16edebddea446302576fc19e556"
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
