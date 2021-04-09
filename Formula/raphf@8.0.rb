# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT80 < AbstractPhp80Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b2cee0646806785fbbdfdfe9dd6bc87fc67446a7ff45124c9f20001593343935"
    sha256 cellar: :any_skip_relocation, big_sur:       "cba2ff8ac7e2bdfec8821e78ffa7db4b4f06e4f15cb3eecd0e74d8b7465b82da"
    sha256 cellar: :any_skip_relocation, catalina:      "745386fcb989a3daa0551b41dd12b0d5ab171558071838d4963f31a6396731a8"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
