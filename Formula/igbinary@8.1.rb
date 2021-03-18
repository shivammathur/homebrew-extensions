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
    rebuild 16
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9b20ac9fdc9a7cd248a09284718d2487e32fd64161942c082ab3111651fe9375"
    sha256 cellar: :any_skip_relocation, big_sur:       "f846a47f242c4f3932f8613b27f9bd6f17d17274d743202a06133c47f46e8a9b"
    sha256 cellar: :any_skip_relocation, catalina:      "3dfaf4e75cd7b01aedd6c16c12413087a1639ad54915d8e0afb10bf6cbf3098f"
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
