# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f5f666d0565ca8c911db7b6b9430f762278a89a20b811287d564503cf99394ce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d0f276b3caca487296c453c7916e32a1f2c63c2e489bee8deb854ad14d4918f9"
    sha256 cellar: :any_skip_relocation, monterey:       "8b85fe0325d503f24b20f245b63218655c239f1fdc14b807f7cb5a298b2bc04d"
    sha256 cellar: :any_skip_relocation, big_sur:        "cec15b5d11da80d15b1adca71c951af1043cfa8d0bc167f7148cff7f1a69c91a"
    sha256 cellar: :any_skip_relocation, catalina:       "61a79243da803e42a515976361203a82cc96857b465ef56d8113aefb3b29b4ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "337e5fb96e3bab0d1c345aa6fde4e7ff07d26585a8da936e43c735370e2bf4d9"
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
