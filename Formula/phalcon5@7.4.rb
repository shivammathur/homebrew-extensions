# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.2.tgz"
  sha256 "787acbddd81b7f8da4771928a6359d59fe9010c980e9de25a59d3efb2d50437e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d7b796abb34661ab45e9c64e18aa492a313761a1a201a583e2171535beca89ef"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d0a0e982c4f6a3a8e67080ef92e3fc1c8bab4982ec5b99248837b5cb3ad56855"
    sha256 cellar: :any_skip_relocation, ventura:        "b1793f6d9f556eaa9c97d6b913348e5023a127ac2260b9841adde498604611aa"
    sha256 cellar: :any_skip_relocation, monterey:       "668576b8c0774e9894663dcb510cf1d4b011b2223aa867bbfb3c9e24bbd72f15"
    sha256 cellar: :any_skip_relocation, big_sur:        "d5b2be53805a7a2c3a4f2834430c5b647f91738920b4c56c9c77cb7017a81949"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd6ce42a8c4000ce3ffdc405c4e2c2c35bd7c08934ea26e2352d7984a8b8a2c9"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
