# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT73 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "98f424470ecf0b1d4996fe59863ffb73dd788a551fae6a528a623c8c43123c7f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "25a6bc816655f5584ca2a5ffbcc99455e7e0f0e0ef811e0efebba910ba924b47"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f4ac6c66062c922c88533f88b7dc05f3bbea01ca29896f9fbeaf85cfe66e9319"
    sha256 cellar: :any_skip_relocation, ventura:        "92f404bb06af41924c83fc857bf5561251e573a89298536f4792565a1f645523"
    sha256 cellar: :any_skip_relocation, monterey:       "2f9d9ca9e69c44c995cad97f34de6fb69fa9c04a310e9c58c144c02f8d35124f"
    sha256 cellar: :any_skip_relocation, big_sur:        "e18a20e264be0c54e93c184df118bdd4213b15c118aa9844bc6c69d532549374"
    sha256 cellar: :any_skip_relocation, catalina:       "6274def3135b2a77f6b7aea38ec25a217d79c37b7ff9377003d7315c6208d6fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4041dc2bf56ad63fd626be85df23e75b4abe25f3d12ec44dbc8eb745e853feaa"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
