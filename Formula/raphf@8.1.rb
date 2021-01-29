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
    rebuild 4
    sha256 cellar: :any_skip_relocation, big_sur: "6762d3f0e485b9ef0e05612a7199c79f35ac28a8d8dbbaf59ef2671e044e623a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8314149b4d19872aeb76fac9d0cc2818445b25cff7daa255029bc3abb48f1029"
    sha256 cellar: :any_skip_relocation, catalina: "3b2370666eec483f6bffd3dd4a93b2d8ca99beadf338dbb00398c72d3327c108"
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
