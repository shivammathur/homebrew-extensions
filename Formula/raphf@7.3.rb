# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT73 < AbstractPhp73Extension
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
    sha256 "ba00133f781ffc11d6f06711c7e4a76ecfe3350837cd351beb6f4c9428e52778" => :big_sur
    sha256 "febc80b04b931c32ea5be26a417b85971dae7cf7133808fb218f9b63fc5e67ea" => :arm64_big_sur
    sha256 "0ee5f9975d0f174fee51b1d2789b80ed41634f07915472d1e657b75210a507ea" => :catalina
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/raphf.so"
    write_config_file
  end
end
