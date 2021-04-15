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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e0908417a988ad5ede6779a38d844956a1f77cfe4689f4ee1e1fc61a3c2192ef"
    sha256 cellar: :any_skip_relocation, big_sur:       "94bf5cb299d9872fe519d36673936f709a9c5ec4cc3b99a44fca8b13ac2e7336"
    sha256 cellar: :any_skip_relocation, catalina:      "5bf8a5cf8355f92c5075caec5f589328b5a45e0d22e11b4cd7c4eecc245e8fb8"
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
