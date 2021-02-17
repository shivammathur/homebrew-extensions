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
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "252e5c1d6203615c5b010163c2bf3900bbb40e2713a87e8484753ee40c79fbeb"
    sha256 cellar: :any_skip_relocation, big_sur:       "8249efe551060d616201cca21670620cd5b1df8ffcee53bf5cb99f85e80f2fb9"
    sha256 cellar: :any_skip_relocation, catalina:      "22a269a597da99c15336f5435cc5cb4204ab2ddfe5c8f54e3f00629638ed6fe0"
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
