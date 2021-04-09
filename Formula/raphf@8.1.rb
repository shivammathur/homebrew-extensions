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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ccaf47da616e01925cfb32ee1c4e41fbdea3ace8885f1bce531166690dc53886"
    sha256 cellar: :any_skip_relocation, big_sur:       "a38b73c8c27bca58afe7c588465cc516f76e92ff79bcc0367586b87ec34275ab"
    sha256 cellar: :any_skip_relocation, catalina:      "98c22f3d97c5bd8f18e9160964e4b68d441fd4af316910cde446c05c3bfdc73c"
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
