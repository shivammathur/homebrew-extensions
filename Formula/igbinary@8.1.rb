# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c8cefe1055f80430f48bad56cb70b6031a8e9f66b24378b270ea81a7e0e693b2"
    sha256 cellar: :any_skip_relocation, big_sur:       "25e15814a5966e9b7a0353fdbf80eba36fb0641b60fc4d1c53ccbe98bf69d27a"
    sha256 cellar: :any_skip_relocation, catalina:      "d70b4b98e9822c0751c4d7d12390f48e196d8fdf9812ce2d61e4e50d058ae790"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
