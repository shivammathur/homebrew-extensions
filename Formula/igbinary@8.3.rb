# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d4455573759ab24fabd1fffb8e38509acabb0b3d38137c64c1766ee74b9aa095"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bd38e5e6f4b76f8d46f5e3dab44d9371f7a76f0a79e1d1fcf9b030f45aafff48"
    sha256 cellar: :any_skip_relocation, monterey:       "519d8a8f2343a5f6e2c4ccf6b2bb709e3a736c3aa55e6e60c4316be65da574b4"
    sha256 cellar: :any_skip_relocation, big_sur:        "bff474b333acd2c2fc4f7224efd4432c062038b5b823678d840d1a4b59b51395"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64484f4a5d28e8e0e6527ea686ba8b9fd296d9eb13e12bf51ac6b94fad684440"
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
