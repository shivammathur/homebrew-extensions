# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "51a046697d86e23820db20bb0113cdb486aef122781d1ae92410a3fce5119fcf"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fdb736c64609b2b16cf1cf88e1b62f710a0e07f67db19e335109171235e6ebad"
    sha256 cellar: :any_skip_relocation, monterey:       "0f7e2a2b03caa2b1a42a23f631f8568043fd7ea6c9b0a734191387f080a24a0d"
    sha256 cellar: :any_skip_relocation, big_sur:        "2022c0b4048732771d74677ebd47f4f651dc7735fee82de2730822c221417c3e"
    sha256 cellar: :any_skip_relocation, catalina:       "84a76775ccd5eff5ff1386bdde139c800bb8b6417a6dc220ed9168917bbe5310"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62e603d05a813f0c72a3d3f7063771e6d4c011d5a6278aca9257dc1a4f589240"
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
