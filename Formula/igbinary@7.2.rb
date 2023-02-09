# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.13.tar.gz"
  sha256 "4400ecefafe0901c2ead0e1770b0d4041151e0c51bcb27c4a6c30becb1acb7da"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1cc18ef130e63c5083eff04367baa03c2c448acef0b521dc58a6e4e5a4aedd5c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c179e6f46260a7906907df896a8a23608ec9f135a4b2f3ebee3db96851cde0af"
    sha256 cellar: :any_skip_relocation, monterey:       "c2970fdf63b1adac26ab9c72fe0ed1eea3a2eee1989cb48a5ff6a413e4fbd51f"
    sha256 cellar: :any_skip_relocation, big_sur:        "afd5c6993444f648140d74720b4ab22ee2341e0e79f38b42cd0508fffdafbd6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8ff52e507872895ea86f81ea595ce6a26e40703b516735138d0e6fa91ff0c9ce"
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
