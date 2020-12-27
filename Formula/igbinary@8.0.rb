# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhp80Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.0.tar.gz"
  sha256 "9a1e1e6fd982aeff70e0ae05b822173d8492cfc9550d6172041d905c5e51da68"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "8daf83d2849a8d18b6239ff905318a7b2a76af7643a9ed4dd08c91ac4af6d090" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file
  end
end
