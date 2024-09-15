# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "daace688d144197ce06dbdc1d2312642de57a2965368976cea9de3507e422a4d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b7c44e16e318c5b2707c14cf279263226c310b1df25e0710316bcb5c0b38ab94"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "cb24781b4eaeafbf2dc154aea2cec3c2c75d67a033cff11f909b7b9a9ee5131e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3d42bb40b2479cf1013c78d539a81e666f78a6493e41df2a5e080be356ea95ef"
    sha256 cellar: :any_skip_relocation, ventura:        "13b88fb4b57f35217c0b359496fd5d6ea12f21486b4caa079a6ec16d01af3371"
    sha256 cellar: :any_skip_relocation, monterey:       "9d513aa6417dab91b971224cc75049a1bfab6a1e0953969ffc7ca294c72fc104"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db87c1605d1181ebec46048b9e171ff18e63738e83e6585207b77ab8b63c4f8f"
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
