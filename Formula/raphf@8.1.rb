# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8c8460f68c397c9d3b382a7275cc734f946677c3c34ea6f8999f467e74d42bb5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "977f7c055e479062bdd94dfc238ad1f304ad9fa63acd3e2a627b5ff7c9a1049d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8b35713dd47fcf7fef50f9e33e67d4e38ef62e593bb2e29157994d6c16de1b2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b3a0c73ffc70c6af5d992c76ef4453c1e2275efb0a98a0bb1f0a88489cd9127f"
    sha256 cellar: :any_skip_relocation, ventura:        "1593cf5f1bdc18855f633a4306ae06751a3a2925b786715353982e1945e343ea"
    sha256 cellar: :any_skip_relocation, monterey:       "2258d2ca2345b1dc3a97c5b199e95cef4cd18cf29eaf8a0b999306a98df8aa6b"
    sha256 cellar: :any_skip_relocation, big_sur:        "b345122c2ff0c6376dde10aaf89fff957f8c9fa6851d84a3948621ada774ff4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c6712fd6b530781b1494c19504a0a677ff9a5df95c68f4d27d69d50210debab"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
