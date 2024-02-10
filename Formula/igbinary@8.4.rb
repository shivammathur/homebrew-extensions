# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "94659cec73830f64637d6070ee041fc97db3a232f65f2d4371973c4062208502"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4389a13e5700d0ffce6888cc3317b70b80460fdbb055e2a10cc66817df19694d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8f0b858c3549d93991256c84fc184e07dcfa6668a3b5dacbb719134000cb48e4"
    sha256 cellar: :any_skip_relocation, ventura:        "e7927cf040b3ba21a526c715725c81b16fb87bc577d4bc134e3ae99efd3b8b28"
    sha256 cellar: :any_skip_relocation, monterey:       "835516d745072fa803558e8b44a1b86c8bf07445c1fd3ae2e41dbdb6068e656f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "95374bfb6176abd2abd154aaf7ad70fbcac10a77b02f8cbc0a447b1f5e09bd46"
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
