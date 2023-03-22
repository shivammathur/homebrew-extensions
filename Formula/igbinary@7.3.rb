# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e1e9397170f4e8ecf703b7bb070b46195b5b83fc71955231e964b25a09c79ec1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "df43c9873a49c5324c8115153d2552170c2d5003b8dd0fc494997012fcf885df"
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
