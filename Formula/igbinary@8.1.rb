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
    rebuild 18
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fc1550d285e229b6d95f74d36d7b51e35d021b21876b1e997794321e0a4c1abd"
    sha256 cellar: :any_skip_relocation, big_sur:       "cf6ad099b75c49973f0668453d1c4a893ef236951fd35e8b17131239e649f30f"
    sha256 cellar: :any_skip_relocation, catalina:      "2a0703c3f6f37426f2fc40673e27a0d2752cc153f47fa3f304f8afdb9f8cf229"
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
