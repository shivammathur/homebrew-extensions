# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.3.tar.gz"
  sha256 "c6bb38235e166ddf5713f464f9ab6d16e85783eefa7825824efd252eea6ac4e5"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "eafdba1efaaf7e464393679845565acc133f0a36ee21c37cd5cdfb19136cf7c5"
    sha256 cellar: :any_skip_relocation, big_sur:       "22fc0e6f81d6be0e44d8942a49a5b57fa0a3011733fc6ef251df0032c9deab29"
    sha256 cellar: :any_skip_relocation, catalina:      "9691b4605b8d0439b5838b78630cdc9fa6e1b129304aba055e952805614e84b2"
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
