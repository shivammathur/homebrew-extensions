# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhp56Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "82e6faa73be9977395206eddb0b2e1be6cf344a6c0d5d3f85493e676bfb67578"
    sha256 cellar: :any_skip_relocation, big_sur:       "d227ffab322d77df2336aca9d0a39f3412a5c19e8556f6a84a8f39ff93a2ecb2"
    sha256 cellar: :any_skip_relocation, catalina:      "8108f24ddc10459908e0944d3b371643090c8a4ed811b1c00fc0bb256990fb3e"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php5"
    add_include_files
  end
end
