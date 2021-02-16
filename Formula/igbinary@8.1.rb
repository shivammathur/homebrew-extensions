# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz?init=true"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ea76d3458104f5eab647530e61c5c00a83952fce1500274829019f45c75d1540"
    sha256 cellar: :any_skip_relocation, big_sur:       "57f36c48e2f8a2122abc493a0f7a3f8027cc0da06d95d301696f7b5bffdca969"
    sha256 cellar: :any_skip_relocation, catalina:      "66c9fa1d624e68bd01e32ab51036597c9ced703a5f7baee6df6f6f2e3c45b2e6"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
