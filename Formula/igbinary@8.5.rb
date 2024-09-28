# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT85 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9448639d0e376565e6d274512e7bdc86869e6a48d77e2ac37ecf7a8f67e93b6a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "41bd3bdfe1fc6b5792e302846d74485d2ce1bb1217031cba6155e8dfb363199e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b4967fc5633e9213be0e46c12204014c741073185a0a9386db4de49a32ec6094"
    sha256 cellar: :any_skip_relocation, ventura:       "c4cdf51fa63d6502bb6df320ea6dfa2049d9d3d54e0531cfbf0eee254efd208f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd1f8580e5015b48fa7878b69e13fa1469e068b70eb4db168efedaa161f549ae"
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
