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
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8a76ae0bc2a483005a618754d024f0e3547aeda74f0ea4b2e64a8cf69a1d81f4"
    sha256 cellar: :any_skip_relocation, big_sur:       "8ab260a7fbb1f3c56730444e33f611b94b7b1d84f032d6b58713f885f8ec067e"
    sha256 cellar: :any_skip_relocation, catalina:      "f17b29ec6485dc58aa30bdf927ad5ef9945e01b38fbaa698a1c3336e9845b434"
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
