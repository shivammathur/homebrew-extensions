# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhp81Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c2f718b2d49d1f8b94e31d63dce0e2328cf56666e1fbbd7152645cf5f4a38429"
    sha256 cellar: :any_skip_relocation, big_sur:       "2b492d3ba0c2872cbc212711ba50e5601916ca1cefb8c023f0a33cd36dbca9e4"
    sha256 cellar: :any_skip_relocation, catalina:      "8779e784b2c98fe9cbf102c6fd34316ea682ac5da3a75547c67aee3d42cd9320"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
