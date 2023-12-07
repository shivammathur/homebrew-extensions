# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5f1e793f00995bd7b6a68a2c9524931d4ef881abf3ae1dcdf8e0295f04553297"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "94d1be659860b4534f455f811d33c7aa01e371a9db9a0a695d8c222f766e3e2b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4327221d34d5782073fd238c34d2f8d5e1eff7f8cf9bde2aa4683105ed690511"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a62a47933ecc05d4298fde719597d18b7c2af1b79151f17dd0da8a99fbca19fa"
    sha256 cellar: :any_skip_relocation, ventura:        "da25f35f076755aae25be6d7f44d9b779765e5c1b246c675fa49fdd5d39a9c21"
    sha256 cellar: :any_skip_relocation, monterey:       "2e426381ebbbece305254762538ed12b373ba92f86a1c1ec37e822fc757b3ba9"
    sha256 cellar: :any_skip_relocation, big_sur:        "24f6ea583d489d686084430b4774b5c2058596a71764e40cc9c1a6183182b238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "93f71f2d175b99cf0c583d9a6c0d23eb43fcf65180058c00204ce760320d0443"
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
