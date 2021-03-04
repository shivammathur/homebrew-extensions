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
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "302f3499813e83a7d3d51fa70d408faf0227305d0787ed5b45ee0c23e4d11b9b"
    sha256 cellar: :any_skip_relocation, big_sur:       "ed8b409245b8b24ade54578eb993501e3e6b40acaecc4c7fd038799ac4f33bcf"
    sha256 cellar: :any_skip_relocation, catalina:      "2049d9dc2d6433b2930f32a98e1d9a7b1ae140bfd65029875ae3e3c978310fb2"
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
