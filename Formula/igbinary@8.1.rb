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
    cellar :any_skip_relocation
    sha256 "d0443e053ed41c7192b37fc4f65cbc68d3488093051cf4ee8bb3896487c690d3" => :arm64_big_sur
    sha256 "14e1f4c87f869fe37ef082a11449b1d0cf5d43a714c43a3184d1bd8de4c371bb" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file
  end
end
