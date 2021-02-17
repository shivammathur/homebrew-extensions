# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhp74Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz?init=true"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f02346e2747c7e969a453acd4aea2fd4b32b149c345e9b6120bd62b6b3643b4c"
    sha256 cellar: :any_skip_relocation, big_sur:       "8de32c138c562d461f4c291e3228bf103dd62940b2fa756c722bc6569f2b6cfb"
    sha256 cellar: :any_skip_relocation, catalina:      "71d3c10f0d4922c6e6dc0cbd62fc968e8559857f8dc09ce34eafb39a651695d5"
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
