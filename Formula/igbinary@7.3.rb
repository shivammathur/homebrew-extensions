# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8f5fa8d43ea7b85c795b767c7cb3e6f3fe44dad638387d318a86bf6b3a3fd9d2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "48dc9bbde29f1e0f875a0de522510ad985a064493919399c4157e59af9043823"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e1e9397170f4e8ecf703b7bb070b46195b5b83fc71955231e964b25a09c79ec1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "df43c9873a49c5324c8115153d2552170c2d5003b8dd0fc494997012fcf885df"
    sha256 cellar: :any_skip_relocation, ventura:        "83f213f0fefa59e619bcbbd31f5e84e85336b061316897bff6c010eae4291488"
    sha256 cellar: :any_skip_relocation, monterey:       "401902199856639e09e436ff2ed1652bb6d14480c4c578b6af9ee2a08c18eb85"
    sha256 cellar: :any_skip_relocation, big_sur:        "3dcb57d49fded93888fabd03b916a54f8928f740f34745f68585434932cb8c4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1e1657e37f4258e1a78628b32c443f00ff8c4e206fcbdd6f004bfb0eef804af8"
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
