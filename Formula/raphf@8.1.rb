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
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7431074645dc05a0e8a972faf95a18e17dfd16c2c29902e7e4e0f05f975e8c3f"
    sha256 cellar: :any_skip_relocation, big_sur:       "287cb4d6ac566528101679953d1eed368098e5b9cb0a5d1fe36d967dc0f58ebf"
    sha256 cellar: :any_skip_relocation, catalina:      "e6e606d8fb0415831db4ea90559edffcf7057a4f42bb86e3c2c96691c23d9285"
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
