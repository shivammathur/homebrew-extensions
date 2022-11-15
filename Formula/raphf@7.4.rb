# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "59284fb22640d07b17e7c5b3213e1e76f4d66a9cd34a68ebf51797d3db6cbe61"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "233f292de8aa4675f2bed7d401ca4f426bb086c8e3fb6da9725e93b637a1671a"
    sha256 cellar: :any_skip_relocation, monterey:       "9c197fdf4e9df7c502c8c139c0372563b08fa6f536d84c6812285a0745668cc7"
    sha256 cellar: :any_skip_relocation, big_sur:        "3e86fc283e0c48130f18be0f3357acafad42c176a37324b02cae50b6f5dff78b"
    sha256 cellar: :any_skip_relocation, catalina:       "c2280b00cd924b72b218a81e774cf01af6edcaa3a3fbcb70cb4f50ac4956b3d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "927a8dfe5522311ed5d4258255747af6edc3ddfc16bcd2f88f0702f8968d72dc"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
