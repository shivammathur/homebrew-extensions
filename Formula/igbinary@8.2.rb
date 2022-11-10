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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8f96194b8c71098772fc61308376540513aec61e5c31d4c59c06e1474d5b8a8f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f5d1e3c151487f29fb02e27e384d9a10a36104c44cc9c4e033429d7fec2c1205"
    sha256 cellar: :any_skip_relocation, monterey:       "63d13bbbc971ebcff24209319f48e15bc562b9b47976e6f19b6edd9cb3eb1d9d"
    sha256 cellar: :any_skip_relocation, big_sur:        "c9bf418fb26aeda27438aa58895b2af25d4c439486230ffb2d2c337dca7626c4"
    sha256 cellar: :any_skip_relocation, catalina:       "eea3b3905d215dd755e21804aaf1489ff6caa205d0800c2163998c7f0ffdb3b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f1bcac0592c122c0419941bfd0041eefd6e1eb0214de4bf079e9a0c2d8e417d7"
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
