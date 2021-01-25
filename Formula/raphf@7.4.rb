# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhp74Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "fc0077670cb6a84f3067c74c862b6385a5159e3ab7df8490ec1c24673058e02d" => :big_sur
    sha256 "4417d85e3e0a928f014008b2674d1869c6da473c9835d8310ea0f8cfd9361090" => :arm64_big_sur
    sha256 "81d05ddab5821df1d769ae37e84ba85e37ba5e54e37f1cc4eaaa2f223e266028" => :catalina
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
