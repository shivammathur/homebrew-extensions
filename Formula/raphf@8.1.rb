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
    cellar :any_skip_relocation
    sha256 "8800823239632b66a35087ac077c72a168f39d3ebf7b9fada61fcbd94e5a1812" => :big_sur
    sha256 "37aa13c8c2da640a4f102fc1aff5c81cba69b68964a4d1b403f115eff9721403" => :arm64_big_sur
    sha256 "24e106b03fb69253d0a8099773643221b6949a352d4a830dfaedb22c4c6ec31d" => :catalina
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
