# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dcf592f590019a6612371706251d6864e43d4c17845f162361914563d449e29f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "085ea0e6dafb226ff6db399156fc2d8c39315316670e96e246351e35c603cd8b"
    sha256 cellar: :any_skip_relocation, monterey:       "7e0968a11bb224c00ebd06e205e965de6be915bf5b3674834c1e03befbb62123"
    sha256 cellar: :any_skip_relocation, big_sur:        "bc9d1279e85bd746c467160efbee82742c1a8132c5f970be88fd09a6b13e84ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "06122e30bd674d12154d8f9fbd3e0cd1220c482b8d014edff08a156b9150894d"
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
