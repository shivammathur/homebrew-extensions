# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhp73Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e5c2c11cf2e3bf4f614969c69eeee0ce7422207ffe6e9a6a07c494edc58aa681"
    sha256 cellar: :any_skip_relocation, big_sur:       "7950f7fcfff1b26ec77124e7850456c94b9a31f33aa382e9c1b979e9c3dbbf1d"
    sha256 cellar: :any_skip_relocation, catalina:      "ab941df08c9434c2525250e0214a198394e85e40b0bf00901ccf9dfe62fc0405"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
