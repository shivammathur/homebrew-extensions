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
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9fe36e929f07b2bd32e62de0ebd3e21a5b604e7acff558314f15595672ae6344"
    sha256 cellar: :any_skip_relocation, big_sur:       "4aee54098311ab1da6ec25f2d0df907044a8ad809dd083dc0552bb3f08fc0f80"
    sha256 cellar: :any_skip_relocation, catalina:      "28fccdabc2e34660d74024fa2169a4f7c55c00594f4ad14c6e043d685979de39"
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
